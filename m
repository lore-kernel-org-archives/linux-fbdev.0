From: Prashant Gaikwad <pgaikwad@nvidia.com>
Date: Thu, 12 Jul 2012 04:20:48 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <4FFE4DD0.7020407@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
In-Reply-To: <4FFD87BD.2030206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 11 July 2012 07:33 PM, Rob Herring wrote:
> On 07/11/2012 07:56 AM, Prashant Gaikwad wrote:
>> Hi,
>>
>> I am working on DT binding for Tegra DVFS.
>>
>> For Tegra, DVFS node mainly consists of frequency and voltage pairs.
>> Frequency in the pair may change for different process. E.g. for process
>> 1 CPU clock frequency could be 900MHz at 1V while for process 2 it could
>> be 1GHz at 1V.
>> Tegra uses vendor specific ids to identify the correct frequency table.
>>
>> Following is the proposed binding for voltage and frequency tables used
>> in DVFS. Looking for comments/suggestions to make it generic.
>>
>> ====DVFS table node=========>> This node defines the voltage configuration for the DVFS which includes
>> the regulator and voltage array.
>>
>> Required properties:
>>
>> reg_id :<regulator phandle>;
>> voltage-table :<voltage array, values in mV>;
>>
>> #address-cells and #size-cells : To identify correct frequency table
>> using process id (or some other vendor specific way).
>>
>> ====Frequency table node=======>>
>> This node defines frequency configuration for the device DVFS.
>>
>> Required properties:
>>
>> In device node need a reference to the DVFS table node.
>>
>> dvfs : the phandle for the DVFS table node
>>
>> frequency-table@n
>>         reg =<n>; dependent on address-cells and size-cells in DVFS
>> table node.
>>         frequencies =<frequency array, values in MHz>;
> You are storing u32 values, why limit the resolution to MHz.
>
> Put the unit in the property names.
>

Unit can be changed, will do it.

>> }
>>
>> Example:
>> -------------------------------------------------------------------------
>>
>> cpu-dvfs-table : dvfs-table {
> This should be located with the node that the frequencies correspond to.
>

With CAR node?

>>                compatible = "nvidia,tegra30-dvfs-table";
>>                reg_id =<&sm0>;
>>                #address-cells =<1>;
>>                #size-cells =<0>;
>>                voltage-array =<750 775 800 825 850 875 900 925 950 975
>> 1000 1025 1050 1100 1125>;
> The SOC is really characterized at all these voltages?

Not really, but different processes of single SoC are characterized for 
different voltages and this array covers all those voltages.

>> };
>>
>> device {
>>               dvfs =<&cpu-dvfs-table>;
>>               frequency-table@102 {
>>                        reg =<0x102>;
>>                        frequencies =<314 314 314 456 456 456 608 608 608
>> 760 817 817 912 1000>;
> I don't see the point of repeating frequencies.
>>               };
>>               frequency-table@002 {
>>                        reg =<0x002>;
>>                        frequencies =<598 598 750 750 893 893 1000>;
>>               };
> How do you determine the voltage for a frequency on table 2?
>
> I'd expect a single property with freq/volt pairs or 2 properties for
> freq and voltage where there is a 1:1 relationship (freq N uses voltage N).


How this will work:

voltage-array =<750 775 800 825 850 875 900  925 950 975 1000 1025 1050 1100 1125>
frequencies-1 =<314 314 314 456 456 456 608  608 608 760 817  817  912  1000>;
frequencies-2 =<598 598 750 750 893 893 1000>;


Freq and voltage has 1:1 relationship but as single voltage table is 
used for different processes we have more entries in voltage table than 
freq table.
Frequency table 1 is mapped till 1100mV while frequency table 2 is 
mapped till 900mV only, it maintains 1:1 relationship.

About repeating frequencies, operating voltage for a frequency would be 
the highest one mapped in the table.
For example, in frequency table 2 operating voltage for 750MHz would be 
825mV while for 893MHz it would be 875mV. Unmapped entries could be 
replaced with 0 to make reading better.

Advantage it provides is single voltage table used for multiple 
frequency tables, as can be observed from above tables, operating 
voltage for 314MHz in freq table 1 is 800mV while there is no frequency 
in table 2 at that voltage.

I know this makes reading difficult but it provides flexibility,

I hope it explains the implementation.

> Rob
>
>> };
>>
>> Thanks&  Regards,
>> Prashant G
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

