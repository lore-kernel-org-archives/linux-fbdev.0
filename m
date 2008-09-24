From: "Thibaut VARENE" <varenet@parisc-linux.org>
Subject: Re: PATCH - Allow more revisions in s1d13...fb
	driver
Date: Wed, 24 Sep 2008 16:10:48 +0200
Message-ID: <7d01f9f00809240710j3b4e9985jf88d56376751ce68@mail.gmail.com>
References: <20080924155931.141c487f.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <varenet@gmail.com>) id 1KiV4z-0006jc-Q0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Sep 2008 14:10:57 +0000
Received: from yx-out-1718.google.com ([74.125.44.154])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KiV4r-0000pm-CX for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Sep 2008 14:10:57 +0000
Received: by yx-out-1718.google.com with SMTP id 3so431661yxi.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 24 Sep 2008 07:10:48 -0700 (PDT)
In-Reply-To: <20080924155931.141c487f.kristoffer.ericson@gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Sep 24, 2008 at 3:59 PM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
>
> The Epson s1d13xxx hardware is common in many handhelds, but our
> driver is currently locked to a single chip revision. This patch
> adds an array of known to work revisions (which can be extended).
>
> Signed-off-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
>
>
> diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
> index b829dc7..c674949 100644
> --- a/drivers/video/s1d13xxxfb.c
> +++ b/drivers/video/s1d13xxxfb.c
> @@ -50,6 +50,11 @@
>  #define dbg(fmt, args...) do { } while (0)
>  #endif
>
> +static const int s1d13xxxfb_revisions[] = {

I believe this should be "static const int __devinitdata
s1d13xxxfb_revisions[]" since the probe function is the only consumer.

Other than that the patch looks formally good to me, but I don't have
any hw to test it against.

HTH

T-Bone

-- 
Thibaut VARENE
http://www.parisc-linux.org/~varenet/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
