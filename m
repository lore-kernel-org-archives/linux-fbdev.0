From: Theodore Kilgore <kilgota@banach.math.auburn.edu>
Subject: Re: aty128fb problems on iMac, kernel 2.8.1
 (fwd)
Date: Sun, 26 Sep 2004 11:25:51 -0500 (CDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409261055420.5509@banach.math.auburn.edu>
References: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
 <1096187234.537.303.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBcTn-0001PY-1a
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 10:06:31 -0700
Received: from banach.math.auburn.edu ([131.204.45.3])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBcTm-00020d-0S
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 26 Sep 2004 10:06:30 -0700
In-Reply-To: <1096187234.537.303.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Thanks.

Someone else made pretty much the same suggestion (to compile the support
into the kernel) two days ago. I did that and the problem is fixed. Now I
am tryint to compile KDE and can't figure out why in h--- I am able to
compile the qt libraries and then when I go on to the nex thing I get an
error message that the qt libraries are not there. But that's nothing to
do with this list.

In case anyone is curious:

This iMac has an ati rage 128, which lspci says is a 4X agp card. So, I
put in the kernel:

under Character devices:
AGP support
r128 support

and then
framebuffer support
aty128fb support

and (because my eyes are 63 years old just like the rest of me)
font support, with sun12x22 fonts installed.

so now I get a nice bootup with those nice big fonts, right away, instead
of the built-in Apple fonts where the characters are the size of tiny
black ants.

Then in xorg.cfg I chose r128 support with framebuffer option. Then X
maxes out at 1240x1024-75, with 24-bit color.

So as I said these problems are solved, and thanks for the help on the
mailing list because I needed for someont to tell me straight-up that it
isn't going to work if all this is done as modules. I still do not
understand completely why not, however, and if anyone has any ideas to try
out, to make that work, then as I said this machine is being built as a
test machine. Just let me know.

I do have one remaining question. This is not an X problem but a console
problem. Sometimes in the console I get an artifact on the right side and
on the bottom of the screen. This happens especially if Midnight Commander
is running, and I switch it to the "background" with Cntrl-O and then
switch the VT and then switch back again. Then the backwards "L" shaped
artifact may become quite visible and is bright blue. I have looked in
/etc/fb.modes to see if the settings there (which are for another card)
might be causing this, due to the settings for "bottom" and "right" being
a bit off, but it does not seem so. Indeed, the settings which show up in
console after bootup, when one types "fbset" are for 1024x768-75. But
the settings which fbset reports, do not agree with the 1024x768-75
settings which are given in /etc/fb.modes. (?).

Do not misunderstand. This is not a burning issue from the perspective of
a user. But it might be a good laboratory test in which one can learn
better how to control the video hardware.

Thanks again for the help.

Theodore Kilgore


On Sun, 26 Sep 2004, Benjamin Herrenschmidt wrote:

>
>
> > So, when I do make modules it says that it compiled the aty128fb module,
> > but it gives two error messages:
> >
> > mac_find_mode  undefined
> >
> > and
> >
> > mac_vmode_to_var  undefined.
>
> Build the fbdev in the kernel, not as a module, there are a number of
> issues with fbdev's as module, especially on Macs where offb (the
> default 8 bits framebuffer) will take over, preventing you from loading
> the specific ATI driver on top of it anyway.
>
> Then, use X "ati" driver with Option "UseFBDev" "true" in the "Device"
> section.
>
> Ben.
>
>


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
