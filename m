From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sun, 24 Nov 2013 00:40:15 +0000
Subject: Re: [ibm-acpi-devel] [PATCH] video: backlight: Remove backlight sysfs uevent
Message-Id: <20131124004015.GA19499@khazad-dum.debian.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131111235700.GA29987@july>
 <002901cedf3c$a7e77a00$f7b66e00$%han@samsung.com>
 <20131112005628.GA2914@khazad-dum.debian.net>
 <1384990859.20536.4.camel@x230>
 <20131121114332.GA23710@khazad-dum.debian.net>
 <20131121143326.GA19773@srcf.ucam.org>
 <20131122113601.GB27196@khazad-dum.debian.net>
 <20131122171556.GA15680@srcf.ucam.org>
In-Reply-To: <20131122171556.GA15680@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-fbdev@vger.kernel.org, 'Kyungmin Park' <kmpark@infradead.org>, kay@vrfy.org, Jingoo Han <jg1.han@samsung.com>, 'Henrique de Moraes Holschuh' <ibm-acpi@hmh.eng.br>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 'Richard Purdie' <rpurdie@rpsys.net>

On Fri, 22 Nov 2013, Matthew Garrett wrote:
> On Fri, Nov 22, 2013 at 09:36:01AM -0200, Henrique de Moraes Holschuh wrote:
> > On Thu, 21 Nov 2013, Matthew Garrett wrote:
> > > The uevent support was initially added to handle systems where pressing 
> > > a hotkey generates an event (good) but the firmware automatically 
> > > changes the brightness (bad). I have absolutely no idea why I added 
> > > BACKLIGHT_UPDATE_SYSFS - BACKLIGHT_UPDATE_HOTKEY solves the problem I 
> > > was trying to solve. I'm not aware of any userspace that relies on 
> > > BACKLIGHT_UPDATE_SYSFS.
> > 
> > Well, either we have userspace that rely on the uevents, or we don't. 
> 
> We have userspace that relies on uevents of type 
> BACKLIGHT_UPDATE_HOTKEY. I don't know that we have userspace that relies 
> on uevents of type BACKLIGHT_UPDATE_SYSFS.

Any OSD application would have to rely on both uevent types, or it is broken
(and to test that, just write a level to sysfs and watch the OSD app fail to
tell you about the backlight level change...)

I don't know about other types of applications, though.  What other type of
applications pay attention to backlight uevents?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
