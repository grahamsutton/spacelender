//==============================================
// Adds and Removes extra rate forms
//
//
//
// Just add #additional-rate-forms id to a div
//==============================================

var numOfRateForms = $(".rate-form").length;

function addRateForm() {
  // Append the "rates_form" partial when the #add-rate-form btn (+) is clicked
  $("#additional-rate-forms").append("#{ escape_javascript( render :partial => 'listings/rates_form', :locals => {:r => r} ) }");

  // Hide if total number of forms hits limit
  toggleAddSubtractButtons($("#additional-rate-forms").children().length);

  // Add one to the number of forms counted
  numOfRateForms++;

  changeChargePeriodSelection(numOfRateForms);
}


// Remove the last "Rate row" when minus button is clicked
function subtractRateForm() {
  $("#additional-rate-forms").children().last().remove();

  // Unhide if total number of forms falls below limit
  toggleAddSubtractButtons($("#additional-rate-forms").children().length);

  // Decrement number of forms from the count
  numOfRateForms--;

  changeChargePeriodSelection(numOfRateForms);
}


// Hide the (+) or (-) sign if the number of rates_forms outgrows the number of options (hourly, weekly, etc)
function toggleAddSubtractButtons(numOfAddedForms) {
  // numOfForms - 1, to account for the one form that is always showing.
  if (numOfAddedForms == parseInt("#{times.count}") - 1) {
    $("#add-rate-form").hide();
  } else {
    $("#add-rate-form").show();
  }
}


// Change the dropdown default selection as forms are added
function changeChargePeriodSelection(numOfForms) {
  var index = numOfForms - 1;  //Minus 1, because index is 0-based
  var optionToSelect = $(".rate-form-select").eq(index).children().eq(index);

  // Select the appropriate value
  optionToSelect.attr("selected", "selected");
  }