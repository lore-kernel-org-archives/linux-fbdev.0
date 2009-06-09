From: InKi Dae <daeinki@gmail.com>
Subject: Re: Samsung SoC Framebuffer Driver issue.
Date: Tue, 9 Jun 2009 11:33:45 +0900
Message-ID: <90b950fc0906081933s47aa9bd0nded77973396a0109@mail.gmail.com>
References: <90b950fc0906072153j6308059eq4d6f864c97a2003d@mail.gmail.com>
	 <4A2D9282.6080609@simtec.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756604AbZFICdz@vger.kernel.org>
In-Reply-To: <4A2D9282.6080609@simtec.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Kyungmin Park <kmpark@infradead.org>

There are my comments about your answers.
And thank you for your answer.

2009/6/9 Ben Dooks <ben@simtec.co.uk>:
> InKi Dae wrote:
>>
>> Hello, =A0Ben =A0Dooks.
>>
>> I am trying to develop Samsung SoC Framebuffer Driver for S5PC100 bu=
t
>> I faced some problems about design. so I have some questions about t=
hose.
>>
>> there are some differences between LCD Controller registers of S3C64=
XX
>> and S5PC100 like the following.
>>
>> . regiters not used by S3C64XX were added to S5PC100 also BPP MODE.
>> . WindowX Palette Data Index registers were removed from lcd
>> controller of S3C64XX and Palette Memory Registers were added to one
>> of S5PC100
>>
>>
>> 1.
>> Your framebuffer driver, drivers/video/s3c-fb.c, is related to only
>> S3C64XX.
>> and I'd like to divide framebuffer driver into common logical driver
>> for supporting S3C64XX and S5PC100 and S5PC100 specific driver.
>> but your driver needs to modifying because calling register control
>> commands in s3c-fb.c directly.
>
> Actually, it should also support the s3c2443 driver. You might find s=
ome
> interesting answers to the further questions by looking at how that w=
orks
> via the architecture specific includes.
>
I missed about S3C2443.
Yes, but I think including architecture specific header files is valid
only in case that all the S3C64XX registers are same with S5PC100.
Actually, almost registers of S5PC100 are same with S3C64XX but
different from some registers as I said before.
If new features for S5PC100 would be added to your driver then we
would find #ifdef CONFIG_S5PC100 in your driver.
this reason is because your driver calls low level functions (writel an=
d readl).
So considering S5PC100 and S5PC110, I think it is good way to call
only generic interfaces.

for example,
s3c_fb_enable() calls low level function (writel) for enabling LCD Cont=
roller.
but my proposal will call generic interface in specific file. like
this fb_enable() -> s3c_fb_enable().
fb_enable(), as generic interface, will call s3c_fb_enable() and
s3c_fb_enable() is specific code (writel and readl are used here).

In case of this, s3c-fb.c, as generic driver, could support S3C2442,
S3C64XX, S5PC100 and S5PC110.
So I would like to divide Samsung SoC Framebuffer Driver into generic
driver and specific driver.

How do you think about that and do you have any idea ?

>> How do you think about that ?
>>
>> 2.
>> S3C64XX LCD Controller's registers are similar with S5PC100's, so I
>> wouldn't modify register prefix.
>> but some registers should added to definition file
>> (arch/arm/mach-s3c6400/include/mach/regs-fb.h).
>
> I don't have documentation for any of these newer chips, so cannot ma=
ke
> much of a comment without any more detailed data.
>
>> which way do you prefer adding some registers to
>> arch/arm/mach-s3c6400/include/mach/regs-fb.h or creating new
>> definition file for S5PC100 ?
>>
>> If you give me your comments for the issues above, I will modify
>> Samsung SoC Framebuffer Driver to be supported for S3C64XX and
>> S5PC100.
>> In the result, I expect that your driver will be divided into logica=
l
>> driver and specific driver supporting S3C64XX and S5PC100 or either
>> S3C64XX or S5PC100.
>> If the driver would be completed, logical driver, s3c-fb.c, would
>> support S3C64XX, S5PC100 and also S5PC110.
>
> I'll let you have a think about this wrt to the answer supplied for #=
1,
> and see if you need any further information about it after that.
>
>> Please give me your comments and advices.
>>
>> Best Regards,
>> InKi Dae.
>
>
> --
> Ben Dooks, Software Engineer, Simtec Electronics
>
> http://www.simtec.co.uk/
>
