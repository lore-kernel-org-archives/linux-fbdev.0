From: Paulo Marques <pmarques@grupopie.com>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Tue, 03 Jul 2007 16:24:18 +0100
Message-ID: <468A6A22.90008@grupopie.com>
References: <200707031607.08511.hjk@linutronix.de>
	<468A6159.6000808@grupopie.com>
	<200707031703.53102.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5kEo-0003S9-Pc for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:24:23 -0700
Received: from bipbip.grupopie.com ([195.23.16.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5kEn-0004y9-A9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:24:22 -0700
In-Reply-To: <200707031703.53102.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Hans-J=FCrgen Koch wrote:
> Am Dienstag 03 Juli 2007 16:46 schrieb Paulo Marques:
>> [...]
>> I've been working on getting the non-palletized 18bpp modes working and =

>> had a preliminar patch that just didn't support packed mode yet (using =

>> 24 bits per pixel).
> =

> Can userspace applications work with such a weired format?
> If yes, I'm looking forward to your patch.

It is not really that weird: rgb is packed 6 bits per component into 18 =

bits. Those 18 bits will then occupy the lower bits of a 24 bit value or =

a 32 bit value depending on using packed or unpacked mode.

I'm doing this for the OpenEZX project to handle some motorola phones =

that have 18bpp support.

Motorola uses this mode in their software, so I suppose Qt already =

supports it.

Nevertheless, it seems a really big waste to have such a colorful =

display and then just use a palletized frame-buffer :P

So, if there are some userspace applications not supporting this mode, =

we should address them, but the support has to be in the kernel first... :(

>> We can either apply this patch as is and I'll just merge my work later, =

>> or I can try to merge both patches and send a single patch upstream. =

>> Either way is fine by me.
> =

> It's probably cleaner to merge two small patches than a big one.

Ok. It is also less stressful for me, too ;)

-- =

Paulo Marques - www.grupopie.com

"All I ask is a chance to prove that money can't make me happy."

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
