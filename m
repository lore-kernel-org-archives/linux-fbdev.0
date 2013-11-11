From: Belisko Marek <marek.belisko@gmail.com>
Date: Mon, 11 Nov 2013 22:20:22 +0000
Subject: Re: [PATCH 1/3] arm: omap2: Export devconf1 bypass and acbias.
Message-Id: <CAAfyv34CyviSt_Jaygr-CYSQdZOBHz14awT3U8=2ZBT14s896g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381784555-18344-1-git-send-email-marek@goldelico.com>
 <1381784555-18344-2-git-send-email-marek@goldelico.com>
 <20131111164917.GN15154@atomide.com>
In-Reply-To: <20131111164917.GN15154@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Tony,

On Mon, Nov 11, 2013 at 5:49 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Marek Belisko <marek@goldelico.com> [131014 14:11]:
>> devconf1 reg access is localized only in mach-omap2 and we need to export
>> updating of devconf1 from omapdss venc driver (bypass and acbias bits).
>> Add simple api call which update only necessary bits.
> ...
>
>> +void update_bypass_acbias(bool bypass, bool acbias)
>> +{
>> +#ifdef CONFIG_ARCH_OMAP3
>> +     int val = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
>> +
>> +     if (bypass)
>> +             val |= OMAP2_TVOUTBYPASS;
>> +     else
>> +             val &= ~OMAP2_TVOUTBYPASS;
>> +
>> +     if (acbias)
>> +             val |= OMAP2_TVACEN;
>> +     else
>> +             val &= ~OMAP2_TVACEN;
>> +
>> +     omap_ctrl_writel(val, OMAP343X_CONTROL_DEVCONF1);
>> +#endif
>
> If this is truly a pinmux, you could already access this
> using pinctrl-single,bits device tree driver.
AFAIK it's not pinmux it's register where we update bits. Or am I
missing something?
>
> But I guess that won't work yet, so it's best to set this
> up as a separate driver like we've done for the USB PHY
> registers.
>
> Regards,
>
> Tony

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
