From: Tony Lindgren <tony@atomide.com>
Date: Tue, 16 Nov 2010 19:38:43 +0000
Subject: Re: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display
Message-Id: <20101116193843.GZ9264@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1288063074-8879-1-git-send-email-samreen@ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087034C101F0B@dbde02.ent.ti.com>
 <1289915437.2668.107.camel@tubuntu>
In-Reply-To: <1289915437.2668.107.camel@tubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "ext Nilofer, Samreen" <samreen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [101116 05:41]:
> On Tue, 2010-11-16 at 07:09 +0100, ext Nilofer, Samreen wrote:
> > Hi,
> >   Any more comments on this patch?
> 
> I'm not sure if enabling kernel options by default is a good thing.
> Somehow I remember that enabling things by default is not looked kindly
> at. Shouldn't they be enabled in the arch/arm/configs config file, if
> they are wanted?
> 
> Tony, do you have opinnion on this? Should DSS features be enabled by
> default in the Kconfig files, or only in the board config file?

The best thing would be to have DSS y if ARCH_OMAP2PLUS or similar,
then have all the features built in and pass the configuration options
in platform_data. That still allows disabling certain features with
Kconfig if needed for memory consumption etc. But the omap2plus_defconfig
should "just work" on all the boards.

Tony
