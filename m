From: Alex Courbot <acourbot@nvidia.com>
Date: Mon, 09 Jul 2012 06:12:21 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <4FFA7645.4050107@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120704104840.GJ24458@pengutronix.de> <4FF43692.2040805@nvidia.com> <20120704130056.GC30009@pengutronix.de> <4FF45DDF.9000306@nvidia.com> <20120704152451.GA7333@sirena.org.uk> <4FF4FDC0.8020405@nvidia.com> <20120705062011.GI30009@pengutronix.de> <4FF53368.6090805@nvidia.com> <20120705064742.GL30009@pengutronix.de> <4FF5459F.5090201@nvidia.com> <20120705075714.GA26428@avionic-0098.mockup.avionic-design.de> <4FF54C6C.1060700@nvidia.com> <4FF5BAEE.3020403@wwwdotorg.org> <00ae01cd5d92$70d1f9f0$5275edd0$%han@samsung.com>
In-Reply-To: <00ae01cd5d92$70d1f9f0$5275edd0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Thierry Reding' <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, 'Sascha Hauer' <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, 'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/09/2012 02:19 PM, Jingoo Han wrote:
> I couldn't agree with Stephen Warren more.
> Could you support DT and non-DT case for backwards compatibility?

Both cases are handled in the new version I just sent. I hope all other 
concerns have also been addressed properly. If I forgot something please 
ping me.

Alex.
