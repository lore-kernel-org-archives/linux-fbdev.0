From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: Re: [patch 1/1] intelfb-voffset
Date: Sat, 28 May 2005 11:02:50 +0200
Message-ID: <429833BA.6010104@worldonline.fr>
References: <20050527220932.865B91C00449@mwinf0201.wanadoo.fr> <20050527155051.5e0fe177.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbxFH-0005sQ-HQ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 May 2005 02:04:39 -0700
Received: from smtp7.wanadoo.fr ([193.252.22.24])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DbxFF-00051q-Ll
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 28 May 2005 02:04:39 -0700
Received: from me-wanadoo.net (unknown [127.0.0.1])
	by mwinf0703.wanadoo.fr (SMTP Server) with ESMTP id 87BFD1000099
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 May 2005 11:04:30 +0200 (CEST)
Received: from worldonline.fr (AGrenoble-152-1-49-140.w82-122.abo.wanadoo.fr [82.122.133.140])
	by mwinf0703.wanadoo.fr (SMTP Server) with ESMTP id B7ADC1000098
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 28 May 2005 11:04:27 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton a =E9crit:

>sylvain.meyer@worldonline.fr wrote:
> =20
>
>>- Add voffset option to avoid conficts with Xorg i810 driver
>>   =20
>>
>
>Please provide more info.
>
>- How does it "avoid conflicts"?
>
    It avoids conflicts in using memory allocations for framebuffer, hw=20
cursor and ring buffer which cannot be corrupted by the X driver. The=20
problem seems to be the exclusive use of BIOS calls in the X driver=20
instead of direct access to the hardware as in the intelfb driver. I=20
don't know what the BIOS do but i can see the corruption. In the X=20
driver, the BIOS is called to increase the stolen memory (part of the=20
aperture memory already allocated by the BIOS) if it is too small. I=20
think it's part of the problem.

>
>- How is the user to know that he needs to provide this module parameter=
?
>
    The default parameter should be ok with default configuration of the=20
X driver. If VideoRam parameter is increased in xorg.conf, maybe a=20
different voffset should be passed to the linux kernel (now VideoRam=20
defaults to 32MB, voffset to 48 MB).
    Anyway, if i have spare time this week-end, i'll come with a small=20
doc. Just to to know, i borrowed this idea to the i810 driver, so the=20
parameter is already in use today.

>
>- Is it not possible to prevent these "conflicts" without the use of a
>  module parameter?
>
    If i had the datasheet of the chips, maybe but now without lobbying=20
Intel and working blind, my answer is no. Sorry.

>IOW: it's really a cop-out to require that the user know about some obsc=
ure
>module parameter to be able to amke their system work correctly.  We
>really, really want these things to "just work".
> =20
>
    Yes, I share your concern but now I don't know how to do it.

Sylvain






-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
