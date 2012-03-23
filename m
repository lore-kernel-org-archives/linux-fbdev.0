From: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Date: Fri, 23 Mar 2012 03:48:51 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <1332473811.3051.5.camel@debian.Gayathri>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
	 <20120312175130.GA18002@srcf.ucam.org>
	 <1331640592.3485.50.camel@debian.Gayathri>
	 <20120313124738.GB10822@srcf.ucam.org>
	 <CABNxG=Dqg26EHmC3vibf3-SjVhby1qgQfMniQObUeh9eJ6SwEw@mail.gmail.com>
	 <20120313133458.GA11574@srcf.ucam.org>
	 <1331688294.2577.19.camel@debian.Gayathri>
	 <1331680373.10557.169.camel@linux-s257.site>
	 <1331692996.3052.8.camel@debian.Gayathri>
	 <1331704278.10557.190.camel@linux-s257.site>
	 <CABNxG=D3y2GQqS1XN=+B0QRScXpufBkPQtP5-SSNEjSavhtW7g@mail.gmail.com>
	 <1331798740.10557.245.camel@linux-s257.site>
	 <1332047432.6304.13.camel@debian.Gayathri>
	 <1332122514.10557.270.camel@linux-s257.site>
	 <1332241764.10557.329.camel@linux-s257.site>
	 <1332269710.3921.31.camel@debian.Gayathri>
	 <1332298845.10557.343.camel@linux-s257.site>
In-Reply-To: <1332298845.10557.343.camel@linux-s257.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joeyli <jlee@suse.com>
Cc: Matthew Garrett <mjg@redhat.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2012-03-21 at 11:00 +0800, joeyli wrote:
> think the hotkey of backlight control only works with acpi_osi=Linux ?

yes , hot key control only works with this option.Any ideas about where
the hot key events gets handled ? I tried logging inside
'acpi_video_device_notify' method in video.c . But the control does not
seem to reach here . 

Thanks, 

Pradeep Subrahmanion

