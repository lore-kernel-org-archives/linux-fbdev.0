From: Prashant Gaikwad <pgaikwad@nvidia.com>
Date: Tue, 17 Jul 2012 12:49:23 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <50055C83.7060700@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <4FFE4DD0.7020407@nvidia.com> <50035582.9070308@gmail.com>
 <CAJOA=zMKE1Z_AsYeWr22k58EDskx0eshEjv9VbLQHKFsA0uThw@mail.gmail.com>
In-Reply-To: <CAJOA=zMKE1Z_AsYeWr22k58EDskx0eshEjv9VbLQHKFsA0uThw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 17 July 2012 12:06 AM, Turquette, Mike wrote:
> On Sun, Jul 15, 2012 at 4:42 PM, Rob Herring<robherring2@gmail.com>  wrote:
>> On 07/11/2012 11:08 PM, Prashant Gaikwad wrote:
>>> On Wednesday 11 July 2012 07:33 PM, Rob Herring wrote:
>>>> On 07/11/2012 07:56 AM, Prashant Gaikwad wrote:
>>>>> cpu-dvfs-table : dvfs-table {
>>>> This should be located with the node that the frequencies correspond to.
>>>>
>>> With CAR node?
>> With the power domain it corresponds to or the cpu nodes.
>>
>>>>>                 compatible = "nvidia,tegra30-dvfs-table";
>>>>>                 reg_id =<&sm0>;
>>>>>                 #address-cells =<1>;
>>>>>                 #size-cells =<0>;
>>>>>                 voltage-array =<750 775 800 825 850 875 900 925 950 975
>>>>> 1000 1025 1050 1100 1125>;
>>>> The SOC is really characterized at all these voltages?
>>> Not really, but different processes of single SoC are characterized for
>>> different voltages and this array covers all those voltages.
>>>
>>>>> };
>>>>>
>>>>> device {
>>>>>                dvfs =<&cpu-dvfs-table>;
>>>>>                frequency-table@102 {
>>>>>                         reg =<0x102>;
>>>>>                         frequencies =<314 314 314 456 456 456 608 608 608
>>>>> 760 817 817 912 1000>;
>>>> I don't see the point of repeating frequencies.
>>>>>                };
>>>>>                frequency-table@002 {
>>>>>                         reg =<0x002>;
>>>>>                         frequencies =<598 598 750 750 893 893 1000>;
>>>>>                };
>>>> How do you determine the voltage for a frequency on table 2?
>>>>
>>>> I'd expect a single property with freq/volt pairs or 2 properties for
>>>> freq and voltage where there is a 1:1 relationship (freq N uses
>>>> voltage N).
>>>
>>> How this will work:
>>>
>>> voltage-array =<750 775 800 825 850 875 900  925 950 975 1000 1025 1050
>>> 1100 1125>
>>> frequencies-1 =<314 314 314 456 456 456 608  608 608 760 817  817  912
>>> 1000>;
>>> frequencies-2 =<598 598 750 750 893 893 1000>;
>>>
>> I don't see the point trying to share a voltage range. Not sharing it is
>> fewer array elements (22 vs 36):
>>
>> voltage-array-1 =<750 825 900 975 1000 1050 1100>;
>> frequencies-1   =<314 456 608 760  817  912 1000>;
>>
>> voltage-array-2 =<750 800 850  900>
>> frequencies-2   =<598 750 893 1000>;
>>
> This is significantly more readable.

Instead of voltage array, I was thinking of following approach to 
represent operating points for DVFS

reg : operating voltage in microvolt
tolerance : can be used to calculate required voltage. (optional, can be 
replaced by other relevant parameter to calculate required voltage)
frequencies : Array of phandle, clock specifier and frequency for all 
the clocks related to this rail.

opp@750000000 {
     reg = <750000000>;
     tolerance = <4>;
     frequency-table@102 {
            reg = <0x102>;
            frequencies = <&osc 0 314000>, <&ref 1 500000>;
     };
};

opp@800000000 {
     reg = <800000000>;
     tolerance = <4>;
     frequency-table@102 {
            reg = <0x102>;
            frequencies = <&osc 0 456000>, <&ref 1 608000>;
     };
     frequency-table@002 {
            reg = <0x002>;
            frequencies = <&osc 0 400000>, <&ref 1 560000>;
     };
};

It represents:
         - 1:1 mapping for voltage/frequency pair.
         - Voltage can be represented as range.
         - relationships between clock domain and rail.

Only issue I see is, if there are large number of operating points it 
will increase data in DT.

Any suggestions?

>
> Regards,
> Mike
>
>> Rob
>>
>>> Freq and voltage has 1:1 relationship but as single voltage table is
>>> used for different processes we have more entries in voltage table than
>>> freq table.
>>> Frequency table 1 is mapped till 1100mV while frequency table 2 is
>>> mapped till 900mV only, it maintains 1:1 relationship.
>>>
>>> About repeating frequencies, operating voltage for a frequency would be
>>> the highest one mapped in the table.
>>> For example, in frequency table 2 operating voltage for 750MHz would be
>>> 825mV while for 893MHz it would be 875mV. Unmapped entries could be
>>> replaced with 0 to make reading better.
>>>
>>> Advantage it provides is single voltage table used for multiple
>>> frequency tables, as can be observed from above tables, operating
>>> voltage for 314MHz in freq table 1 is 800mV while there is no frequency
>>> in table 2 at that voltage.
>>>
>>> I know this makes reading difficult but it provides flexibility,
>>>
>>> I hope it explains the implementation.
>>>
>>>> Rob
>>>>
>>>>> };
>>>>>
>>>>> Thanks&   Regards,
>>>>> Prashant G
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

