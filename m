From: Mitch Bradley <wmb@firmworks.com>
Date: Tue, 31 Jul 2012 12:22:17 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <5017CDF9.2060304@firmworks.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com> <1343390750-3642-2-git-send-email-acourbot@nvidia.com> <50170EA0.1010408@wwwdotorg.org> <5017B434.2010706@nvidia.com> <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120731105640.GD16155-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On 7/31/2012 6:56 PM, Thierry Reding wrote:
> On Tue, Jul 31, 2012 at 07:32:20PM +0900, Alex Courbot wrote:
>> On 07/31/2012 07:45 AM, Stephen Warren wrote:
>>> I wonder if using the same structure/array as input and output would
>>> simplify the API; the platform data would fill in the fields mentioned
>>> above, and power_seq_build() would parse those, then set other fields in
>>> the same structs to the looked-up handle values?
>>
>> The thing is that I am not sure what happens to the platform data
>> once probe() is done. Isn't it customary to mark it with __devinit
>> and have it freed after probing is successful?
> 
> No, platform data should stay around forever. Otherwise, consider what
> would happen if your driver is built as a module and you unload and load
> it again.
> 
>> More generally, I think it is a good practice to have data
>> structures tailored right for what they need to do - code with
>> members that are meaningful only at given points of an instance's
>> life tends to be more confusing.
> 
> I agree. Furthermore the driver unload/reload would be another reason
> not to reuse platform data as the output of the build() function.
> 
> But maybe what Stephen meant was more like filling a structure with data
> taken from the platform data and pass that to a resolve() function which
> would fill in the missing pieces like pointers to actual resources. I
> imagine a managed interface would become a little trickier to do using
> such an approach.
> 
>>> If the nodes have a unit address (i.e. end in "@n"), which they will
>>> have to if all named "step" and there's more than one of them, then they
>>> will need a matching reg property. Equally, the parent node will need
>>> #address-cells and #size-cells too. So, the last couple lines would be:
>>>
>>> 		power-on-sequence {
>>> 			#address-cells = <1>;
>>> 			#size-cells = <0>;
>>> 			step@0 {
>>> 				reg = <0>;
>>
>> That's precisely what I would like to avoid - I don't need the steps
>> to be numbered and I certainly have no use for a reg property. Isn't
>> there a way to make it simpler?
> 
> It's not technically valid to not have the reg property. Or
> #address-cells and #size-cells properties for that matter.

I'm not keen on this representation where individual steps are nodes.
That seems like it could end up being too "heavyweight" for a long sequence.


> 
> Thierry
> 
> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
