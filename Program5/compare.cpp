#include <iostream>
#include <vector>
using namespace std;

void get5(vector<int>& vec)
{
    int num;
    for (int i = 0; i < 5; ++i)
    {
        cin >> num;
        vec.push_back(num);
    }
}

vector<int> get_common(vector<int> vec1,vector<int> vec2)
{
    vector<int> common;
    for (int i = 0; i < vec1.size(); ++i)
    {
        bool unique = true;
        for (int j = 0; j < common.size(); ++j)
        {
            if (vec1[i] == common[j])
            {
                unique = false;
            }
        }

        if (!unique)
        {
            continue;
        }

        for (int j = 0; j < vec2.size(); ++j)
        {
            if (vec1[i] == vec2[j])
            {
                common.push_back(vec1[i]);
                break;
            }
        }
    }
    return common;
}

void display_vec(vector<int> vec)
{
    for (int i = 0; i < vec.size(); ++i)
    {
        cout << vec[i] << " ";
    }
    cout << endl;
}

int main()
{
    vector<int> vec1;
    vector<int> vec2;
    vector<int> common;

    cout << "Enter first set of 5 positive numbers" << endl;
    get5(vec1);
    cout << "Enter second set of 5 positive numbers" << endl;
    get5(vec2);
    
    cout << endl;

    common = get_common(vec1,vec2);
    
    if (common.size() == 0)
    {
        cout << "The sets you entered have no numbers in common" << endl;
    }
    else
    {
        cout << "The sets you entered have the following number(s) in common: " << endl;
        display_vec(common);
    }

    return 0;
}
