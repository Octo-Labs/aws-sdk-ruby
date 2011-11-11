# Copyright 2011 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

When /^I create a domain named "([^"]*)"$/ do |domain_name|
  create_domain_high_level(domain_name)
end

When /^I get the domain name "([^"]*)"$/ do |domain_name|
  @domain = @sdb.domains[domain_name]
end

When /^I delete the domain$/ do
  @domain.delete
end

When /^I enumerate domains$/ do
  @domains = []
  @sdb.domains.each do |domain|
    @domains << domain
  end
end

Then /^I can get metadata from the domain$/ do
  @metadata = @domain.metadata
  @metadata.should be_a(AWS::SimpleDB::DomainMetadata)
end

Then /^The domain should be named "([^"]*)"$/ do |domain_name|
  @domain.name.should == domain_name
end

Then /^The domain should exist$/ do
  @domain.exists?.should == true
end

Then /^The domain should not exist$/ do
  @domain.exists?.should == false
end

Then /^A domain named "([^"]*)" should be in the list$/ do |domain_name|
  klass = AWS::SimpleDB::Domain
  @domains.detect{|domain| domain.name == domain_name }.should be_a(klass)
end