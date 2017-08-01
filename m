From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 09:41:38 +0000
Subject: Re: [sm750fb] Sunix 2D VGA controller causes kernel panic and crash on boot
Message-Id: <12729534.0lnoZXW8NA@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <b04b0b06f2e7dbb0f9d3db29a86e0a1a@tomgie.de>
In-Reply-To: <b04b0b06f2e7dbb0f9d3db29a86e0a1a@tomgie.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Hi,

I added staging mailing list and Greg to Cc:
(sm750fb driver is a part of STAGING subsystem,, not FBDEV one).

On Tuesday, August 01, 2017 08:44:42 AM Tommy Giesler wrote:
> I have recently submitted a bug report to the Ubuntu bugtracker, since 
> one of our test installations of Ubuntu 17.10 kept failing to boot and I 
> was pointed to this mailing list.
> 
> The system is using a Sunix 2D graphics controller, which uses a Silicon 
> Motion SM750, for video output.
> 
> Starting with Kernel 4.11 the system was no longer able to boot when 
> using the sm750fb module.
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1707641
> 
> After blacklisting the module the system was working fine again. There 
> were no known issues prior to Kernel 4.11.
> 
> Since all the log files were already attached in the Ubuntu bugtracker, 
> I hope it is fine, that I don't attach them here again.
> 
> Please let me know, if you need any further information.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

