From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Do set var even if
 no	fb_check_var() provided.
Date: Thu, 28 Aug 2008 23:45:41 +0200
Message-ID: <48B71C85.5060001@gmx.de>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org> <20080828074521.GO16680@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYpJO-0006QZ-KR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 14:45:50 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KYpJO-0001i5-18
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 14:45:50 -0700
In-Reply-To: <20080828074521.GO16680@sci.fi>
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
To: Helge Deller <deller@gmx.de>, linux-fbdev-devel@lists.sourceforge.net

Ville Syrj=E4l=E4 wrote:
> On Wed, Aug 27, 2008 at 11:49:15PM +0200, Helge Deller wrote:
>> Geert Uytterhoeven wrote:
>>> On Wed, 27 Aug 2008, Takashi Yoshii wrote:
>>>> The behavior of FBIOSET_VSCREENINFO seems to be weired on FB which does
>>>> not
>>>>  provides fbops->fb_check_var.
>>>> It doesn't set anything, but gets info->var instead, and returns no
>>>> error. It is just same as FBIOGET_VSCREENINFO does.
>>>>
>>>> IMHO, this should be one of the following candidates,
>>>>  1. set var without check.
>>>>  2. do nothing but return error (setting var is not supported).
>>>> or
>>>>  3. it's a bug (fb_check_var should always be provided).
>>>>
>>>> The patch at the bottom implements "1".
>>>>
>>>> Because I don't know API specification, nor the history of the code,
>>>> I would like people who knows well to discuss this.
>>> If the driver doesn't provide a fb_check_var(), it means it cannot
>>> change video mode. Hence this rules out #1.
>>>
>>> #2 is not acceptable, as it will break existing applications. It's also
>>> incorrect, as FBIOPUT_VSCREENINFO should succeed for supported modes.
>>> For unsupported modes, the mode should be rounded up to a supported mod=
e,
>>> if possible. In the case of drivers that support one fixed mode only, t=
his
>>> rounding up is relaxed to `rounding' to the sole supported mode.
>>>
>>> #3 is also wrong, as fb_check_var() has been deliberately made optional=
 to
>>> simplify drivers that support one fixed mode only.
>>>
>>> Conclusion: nothing should be changed?
>> I'm not sure.
>> On parisc we just stumbled over exactly this problem where I think Takas=
hi's
>> proposal "1." is probably the right solution.
> =

> What about this?
> =

> 4. Provide a generic check_var() that does some basic sanity checking
> against info->var (eg. check xres, yres and bits_per_pixel).

Yes, possible.
But that wouldn't solve issues with Xorg's current implementation, as =

Xorg is currently checking the monitor sync values as well (see =

https://bugs.freedesktop.org/show_bug.cgi?id=3D17153)

Helge

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
