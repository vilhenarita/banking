defmodule Banking.ProfileTest do
  use Banking.DataCase, async: true

  @valid_attributes %{name: "Jane Doe", cpf: "23842786069"}

  describe "changeset/1" do
    test "profile with valid attributes" do
      profile = Banking.Profile.changeset(@valid_attributes)
      assert profile.valid?
    end
  end

end
