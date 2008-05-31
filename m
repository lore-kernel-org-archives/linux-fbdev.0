From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 2/5] pxafb: add shared
	framebuffer interface
Date: Fri, 30 May 2008 20:49:45 -0400
Message-ID: <45a44e480805301749yea2b4ean393cd426144459c4@mail.gmail.com>
References: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212150530-14941-3-git-send-email-jayakumar.lkml@gmail.com>
	<20080530191002.3f63cf6f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2FI2-0001Z7-Q7 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 17:49:46 -0700
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2FI1-0008OZ-JO
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 17:49:46 -0700
Received: by wf-out-1314.google.com with SMTP id 27so84144wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 May 2008 17:49:45 -0700 (PDT)
In-Reply-To: <20080530191002.3f63cf6f.krzysztof.h1@poczta.fm>
Content-Disposition: inline
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, May 30, 2008 at 1:10 PM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
>
> This one should be rather:
>
> +               if (inf->custom_xfer_div)
> +                       fbi->fb.fix.smem_len  /= inf->custom_xfer_div;
>
> Otherwise is does nothing (the function ends here).
>

Thanks for catching it. Will fix and repost.

jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
