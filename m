From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Tue, 06 Mar 2007 14:53:25 +0800
Message-ID: <1173164006.6285.8.camel@daplas>
References: <20070226144744.GA3615@DervishD>
	 <1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD>
	 <1172510654.7101.11.camel@daplas> <20070226203223.GA161@DervishD>
	 <1172617755.13422.0.camel@daplas> <20070301160139.GA102@DervishD>
	 <1173144817.7219.1.camel@daplas>  <20070306062528.GF20292@DervishD>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pIIGclcRZxlYKt1EbrGS"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965808AbXCFGvh@vger.kernel.org>
In-Reply-To: <20070306062528.GF20292@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: DervishD <lkml@dervishd.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-pIIGclcRZxlYKt1EbrGS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-03-06 at 07:25 +0100, DervishD wrote:
>     Hi Antonino :)
> 
>  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > On Thu, 2007-03-01 at 17:01 +0100, DervishD wrote:
> > >  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > > > Can you try this patch?  It might help with the screen
> > > > corruption.
> > > 
> > >     With the patch, the scroll slows to a crawl and the system is
> > >     unusable. The time to scroll 30 lines is about a minute or so
> > >     (probably more, I just measured for a while).
> > > 
> > >     If you want me to test other patches, just tell :)
> > 
> > Can you change the mdelay to udelay and use higher/lower delay values
> > to see if there's any improvement?
> 
>     Yes, as soon as I can build a new kernel and reboot. Any suggested
> value?

You can start with 5 and increment by 5.  So you need not reboot each
time, compile tdfxfb as a module, and set CONFIG_HW_CONSOLE_BINDING=y
(under drivers->char). Make sure you have vbetool, and use the attached
script.  Thus:

modprobe tdfxfb
unbind.sh
rmmod tdfxfb
edit, make, make modules_install
modprobe tdfxfb
repeat

The script assumes vbetool is in /usr/sbin, if not just edit. Also,
unbinding will only work if X (or any graphics app, for that matter) is
not loaded.

Tony


--=-pIIGclcRZxlYKt1EbrGS
Content-Disposition: attachment; filename=unbind.sh
Content-Type: application/x-shellscript; name=unbind.sh
Content-Transfer-Encoding: 7bit

#!/bin/bash
# Unbind fbcon

# Change this to where your actual vgastate file is located
# Or Use VGASTATE=$1 to indicate the state file at runtime
VGASTATE=/usr/local/share/vgastate/vgastate

# path to vbetool
VBETOOL=/usr/sbin


for (( i = 0; i < 16; i++))
do
  if test -x /sys/class/vtconsole/vtcon$i; then
      if [ `cat /sys/class/vtconsole/vtcon$i/name | grep -c "frame buffer"` \
           = 1 ]; then
	    if test -x $VBETOOL/vbetool; then
	       echo Unbinding vtcon$i
	       $VBETOOL/vbetool vbemode set 3
	       echo 0 > /sys/class/vtconsole/vtcon$i/bind
	    fi
      fi
  fi
done


--=-pIIGclcRZxlYKt1EbrGS--
