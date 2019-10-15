<?php
/////////////////////////////////
///// MAIN CALCULATION FILE /////
/////////////////////////////////


include("../admin/db_connection.php");
$drug_name = htmlspecialchars($_POST['drug'], ENT_QUOTES, 'UTF-8');

// Find drug id
$drug_id_conn = $conn->prepare("SELECT id FROM Products WHERE Products.name=?");
$drug_id_conn->bind_param("s", $drug_name);
$drug_id_conn->execute();
$drug_id_conn->bind_result($drug_id);
$drug_id_conn->fetch();
$drug_id_conn->close();


// SELECTION OPTIONS
// requires strength of the drug eg. 10mg
// returns JSON of all the duration options of the drug with the specified strength value
if(isset($_POST['strength']) && !isset($_POST['ppb']))
{
    $drug_strength = htmlspecialchars($_POST['strength'], ENT_QUOTES, 'UTF-8'); // the asked strength value
    $drug_strength_arr = explode(' ', $drug_strength); // remove the sspaces

    $durations = array(); // all durations array

    // Get all the dosage and duration pairs from the db
    $all_strengths = $conn->prepare("SELECT DISTINCT dosage, dosage_unit, duration, pills_per_box FROM `Product_Properties` WHERE product_id = ? AND dosage = ? AND dosage_unit = ? order by pills_per_box");
    $all_strengths->bind_param("iss", $drug_id, $drug_strength_arr[0], $drug_strength_arr[1]);
    if($all_strengths->execute())
    {
        $result = $all_strengths->get_result();
        while($strength_arr = $result->fetch_assoc())
        {
            $new_duration = $strength_arr['duration'] . ' ' . $strength_arr['pills_per_box'];
            $durations[] = $new_duration;
        }
    }

    $all_strengths->close();
    echo json_encode($durations);
}


// COMPANY RESULTS FROM DURATION AND STRENGTH
// requires strength of the drug eg. 10mg and ppb (pills per box)
// returns the HTML of the companies
// default order is by price
// other order options are 
if(isset($_POST['strength']) && isset($_POST['ppb']))
{
    $drug_strength = htmlspecialchars($_POST['strength'], ENT_QUOTES, 'UTF-8'); // the asked strength value
    $drug_strength_arr = explode(' ', $drug_strength); // remove the spaces
    $drug_ppb = htmlspecialchars($_POST['ppb'], ENT_QUOTES, 'UTF-8'); // the asked strength value

    $order_by_query = "";
    if(isset($_POST['options']))
    {
        $selectedOptions = htmlspecialchars($_POST['options'], ENT_QUOTES, 'UTF-8');
        $optionsArray = explode(',', $selectedOptions);
        $count = 0;
;       for($i = 0; $i < sizeof($optionsArray); $i++)
        {
            if(!empty($optionsArray[$i]))
            {
                if($count === 0)
                {
                    $order_by_query .= "order by ";
                    $count++;
                }
                else
                {
                    $order_by_query .= ", ";
                }
                
                if($optionsArray[$i] == "total-price") $order_by_query .= "price + consultancy_fee + delivery_fee asc";
                elseif($optionsArray[$i] == "price") $order_by_query .= "price asc";
                elseif($optionsArray[$i] == "consultancy") $order_by_query .= "consultancy_fee asc";
                elseif($optionsArray[$i] == "delivery-fee") $order_by_query .= "delivery_fee asc";
                elseif($optionsArray[$i] == "trustpilot") $order_by_query .= "trustpilot_score desc";
                elseif($optionsArray[$i] == "google") $order_by_query .= "google_score desc";
                elseif($optionsArray[$i] == "feefo") $order_by_query .= "feefo_score desc";
            }
        }
    }

    $search_result_html = "";

    $all_drugs = $conn->prepare("select info, image_url, logo_url, Brands.name, delivery_fee, dosage, dosage_unit, pills_per_box, price, consultancy_fee, delivery_time, trustpilot_score, google_score, feefo_score from Products 
                                  left join Product_Properties on Product_Properties.product_id = Products.id 
                                  left join Brands_Products on Brands_Products.product_id = Product_Properties.id
                                  left join Brands on Brands.id = Brands_Products.brand_id
                                  where Products.name = ? and dosage = ? and dosage_unit = ? and pills_per_box = ? " . $order_by_query );
    $all_drugs->bind_param("ssss", $drug_name, $drug_strength_arr[0], $drug_strength_arr[1], $drug_ppb);
    if($all_drugs->execute())
    {
      $result = $all_drugs->get_result();
      while($drug_arr = $result->fetch_assoc())
      {
        $trustpilot = "N/A";
        $google = "N/A";
        $feefo = "N/A";
        if(isset($drug_arr["trustpilot_score"]) &&  $drug_arr["trustpilot_score"] != 0) $trustpilot=$drug_arr["trustpilot_score"];
        if(isset($drug_arr["google_score"]) &&  $drug_arr["google_score"] != 0) $google=$drug_arr["google_score"];
        if(isset($drug_arr["feefo_score"]) &&  $drug_arr["feefo_score"] != 0) $feefo=$drug_arr["feefo_score"];
        
        $search_result_html .= '
          <div class="job-box mt-20">
            <div class="row job-list text-center">
              <div class="col-md-2 align-self-center">
                <img class="img-fluid d-block mx-auto" src="../'.$drug_arr["logo_url"].'" alt="">
              </div>
              <div class="col-md-2 align-self-center">
                <h5><a class="mt-20 text-black" href="#">'.$drug_arr["name"].'</a> </h5>
                <div class="mt-10">
                  <span>Trustpilot Score: '.$trustpilot.'</span><br>
                  <span>Google Score: '.$google.'</span><br>
                  <span>Feefo Score: '.$feefo.'</span>
                </div>
              </div>
              <div class="col-md-2 align-self-center">
                <p>Delivery Info:</p>
                <h5 class="text-success">'.$drug_arr["delivery_time"].'</h5>
                <h6 class=';
                if($drug_arr["delivery_fee"]==0) $search_result_html .= '"text-success"'; else $search_result_html .= '"text-warning"'; $search_result_html .= '">£'.$drug_arr["delivery_fee"].'</h6> 
              </div>
              <div class="col-md-2 align-self-center">
                <p>Tablet Price: </p><h5>£'.number_format((float)$drug_arr["price"], 2).'</h5> 
                <p>£'.number_format((float)$drug_arr["price"]/(int)$drug_arr["pills_per_box"], 2).' per pill</p>
              </div>
              <div class="col-md-2 align-self-center">
                <p>Consultancy Fee: </p>
                <p';
                if($drug_arr["consultancy_fee"]>0)$search_result_html .= ' class="text-danger"';
                $search_result_html .='>£'.number_format((float)$drug_arr["consultancy_fee"], 2).'</p>
              </div>
              <div class="col-md-2 align-self-center">
                <h5>Total: <span class="text-success">£'.(number_format((float)$drug_arr["price"], 2)+number_format((float)$drug_arr["consultancy_fee"], 2)+number_format((float)$drug_arr["delivery_fee"], 2)).'</span></h5>
                <a class="button icon medium" href="#"> choose </a>
              </div>
            </div>
          </div>';
      }

      $all_drugs->close();
    }
    echo $search_result_html;
}



?>