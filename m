From: Mark Zhang <nvmarkzhang@gmail.com>
Date: Mon, 21 Jan 2013 08:35:37 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <50FCFDD9.6000203@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <1358591420-7790-3-git-send-email-acourbot@nvidia.com> <50FCEFDE.8000705@gmail.com> <1966511.aoasnExaly@percival>
In-Reply-To: <1966511.aoasnExaly@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 01/21/2013 04:24 PM, Alex Courbot wrote:
> On Monday 21 January 2013 15:35:58 Mark Zhang wrote:
>>> +	backlight {
>>> +		compatible = "pwm-backlight-ventana";
>>> +		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 
> 208
>>> 224 240 255>; +		default-brightness-level = <12>;
>>> +
>>> +		pwms = <&pwm 2 5000000>;
>>
>> After read the codes of tegra pwm driver & pwm framework, I got to know
>> the meaning of this property. So I think we need to add a doc(e.g:
>> Documentation/devicetree/bindings/video/backlight/nvidia,tegra20-bl.txt)
>> to explain this, "Documentation/devicetree/bindings/pwm/pwm.txt" doesn't
>> explain this, because this may be different between different pwm drivers.
> 
> The bindings are in Documentation/devicetree/bindings/video/backlight/pwm-
> backlight.txt . But you are right that the power supplies and GPIO will 
> require a description of their own - I omitted it for this version because I 
> am not sure what the driver should be called.
> 

The description of this property in pwm-backlight.txt is:

"pwms: OF device-tree PWM specification (see PWM binding[0])
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt"

So you can't get any useful infos from that. That's why I propose to add
a tegra specific doc in
"Documentation/devicetree/bindings/video/backlight" directory.

> The panel used on Ventana is a Chunghwa CLAA101WA01A, maybe that's the name we 
> should use for the compatible string instead (and rename the driver 
> accordingly).
> 
>> So according to the filename, I think we can put all tegra boards codes
>> here, right? Just like what you do for Ventana, if I wanna add support
>> for cardhu, I can define similar functions -- let's say "init_cardhu",
>> "exit_cardhu", "notify_cardhu" and "notify_after_cardhu", right?
> 
> That was my initial intention, yes.
> 
>> But I think if we do in this way, the file will become very long soon.
>> And there are a lot of redundant codes in it. So do you have any
>> suggestions?
> 
> If we decide to make a "Tegra" driver, then I don't think the size of the file 
> is a big issues, as long as one can easily navigate into it. It will make 
> sense to do this since Tegra kernels should include support for all the 
> boards.
> 
> If we go and name the drivers after their actual panel names, we should 
> definitely put them into separate files. The Tegra configuration could then 
> include them all by default to make sure all boards are supported.

I don't think use panel name instead of board name is a good idea.
Developers may not be familiar with panel names. So if we use panel
name, we have to search and read a lot of manual to find out what the
panel is.

I'd rather putting all stuffs in pwm_bl_tegra.c than separating them.

Mark
> 
> Alex.
> 
