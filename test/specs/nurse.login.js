const {_, assert, Constants} = require('../utils');

describe('NA-16 -- login as nurse and check patient details page', function(){
  this.retries(1);

  it('Go home page', function(){
    browser.url('/');
    var title = browser.getTitle();
    assert.equal(title, 'Population Health');
  });

  it('enter nurse username and password', function(){
    browser.setValue('input[name="username"]', 'doctor');
    browser.setValue('input[name="password"]', 'Melissa1');
    browser.click("button=Submit");
    browser.waitForExist("div*=Show All Patients", Constants.wait);
  });

  it('click the first patient on the right side patient nav bar', function(){
    browser.waitForExist("div#left-nav-content a.item", Constants.wait);
    ele = browser.elements('div#left-nav-content a.item').value;
    ele[0].click();
    browser.waitForExist("div.edit-save-button");
  });

  it('check Medicare Id, name, age, birthday, phone, address, notes, diagnosis & care plan, latest measurements, and alerts', function(){
    let content = browser.getText("div.user-header-profile");
    assert.include(content, 'Medicare ID', "Medicare ID field is included");
    assert.include(content, 'years old', "age is included");
    assert.include(content, 'Born on', "birthday is included");
    assert.match(content, /[0-9]{3}-[0-9]{3}-[0-9]{3}/, "phone number is included"); // should be /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/
    assert.include(content, 'United States', "country of address is included");
    assert.match(content, /[0-9]{5}/, "zip code of address is included");

    let diagnosisCard = browser.elements("div.user-card").value[0].getText();
    assert.include(diagnosisCard, 'Diagnosis & Care Plan', "Diagnosis & Care Plan is included");

    let latestMeasurementsCard = browser.elements("div.user-card").value[1].getText();
    assert.include(latestMeasurementsCard, 'Latest Measurements', "Latest Measurements is included");
    assert.include(latestMeasurementsCard, 'Blood Pressure', "Blood Pressure is included");
    assert.include(latestMeasurementsCard, 'Blood Glucose', "Blood Glucose is included");
    assert.include(latestMeasurementsCard, 'Body Weight', "Body Weight is included");
    assert.include(latestMeasurementsCard, 'Pulse Oximeter', "Pulse Oximeter is included");
    assert.include(latestMeasurementsCard, 'Heart Rate', "Heart Rate is included");
  });

});