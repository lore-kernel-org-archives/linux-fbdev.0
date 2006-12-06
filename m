From: James Simmons <jsimmons@infradead.org>
Subject: Re: Display class
Date: Wed, 6 Dec 2006 19:13:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0612061859320.28745@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
 <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
 <20061205171401.fd11160d.randy.dunlap@oracle.com>
 <Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
 <20061206101434.8acb229a.randy.dunlap@oracle.com>
 <Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
 <20061206105724.cf7b39bc.randy.dunlap@oracle.com>
Mime-Version: 1.0
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061206105724.cf7b39bc.randy.dunlap@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Miguel Ojeda <maxextreme@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>, linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org


> > > > That patch was rought draft for feedback. I applied your comments. This 
> > > > patch actually works. It includes my backlight fix as well.
> > > 
> > > Glad to hear it.  I had to make the following changes
> > > in order for it to build.
> > > However, I still have build errors for aty.
> > 
> > Ug. I see another problem. I had backlight completly compiled as a 
> > module! Thus it hid these compile errors. So we need also a 
> > CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE check as well. Can sysfs handle this 
> > well or would it be better the the backlight class be a boolean instead?
> 
> SCSI works as a module and it uses sysfs.
> See drivers/scsi/scsi_sysfs.c.
> Does that answer your question?  I wasn't quite sure what
> the question was.

I'm scratching my head on how to configure a modular driver and 
two modular sysfs classes. 
 
> Next question, based on:
> drivers/built-in.o: In function `probe_edid':
> (.text.probe_edid+0x42): undefined reference to `fb_edid_to_monspecs'
> 
> Should backlight and/or display support depend on
> CONFIG_FB?  Right now they don't, so the above can happen...

I already sent a patch to Andrew to make backlight/lcd work independent of
CONFIG_FB. Display is still in the alpha stage. In time it will work 
independent of CONFIG_FB.

