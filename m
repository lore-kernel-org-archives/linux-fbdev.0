From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH][RFC] Add support for Epson S1D13806 FB
Date: Mon, 14 Mar 2005 21:53:48 +0800
Message-ID: <200503142153.48697.adaplas@hotpop.com>
References: <20050314133427.56F31365905@mail.esiee.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAq1B-00024T-Ok
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:54:01 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAq19-0001nD-I2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 05:54:01 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 91AAEF72FA2
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 13:53:53 +0000 (UTC)
In-Reply-To: <20050314133427.56F31365905@mail.esiee.fr>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Thibaut VARENE <varenet@esiee.fr>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Thibaut VARENE <T-Bone@parisc-linux.org>, Antonino Daplas <adaplas@pol.net>, Ben Dooks <ben-linux-arm@fluff.org>

On Monday 14 March 2005 21:34, Thibaut VARENE wrote:
> -------------------
>
> > On Mon, 14 Mar 2005, Paul Mundt wrote:
> > > On Mon, Mar 14, 2005 at 08:15:13PM +0800, Antonino A. Daplas
>
> wrote:

> Good point. Actually that's a bad thing we did on our platform: we
> didn't add the '-1' to the platform device ranges, so there was no
> need for the '+1'.
>
> I guess it's The Good Thing to do to add a '+1' here, I'll take care
> of changing our platform specific bits to match this.
>
> Thanks for pointing that out.
>
> Let me know if I should resubmit the patch.

Once the platform bits are fixed, if ever, let me know or submit an
incremental patch.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
