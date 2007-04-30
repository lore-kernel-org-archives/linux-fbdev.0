From: <EddyFu@via.com.tw>
Subject: Re: [PATCH 2/5] viafb: Framebuffer driver for
	VIA UniChrome/Chrome9 HC
Date: Mon, 30 Apr 2007 09:36:26 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB803720772@exchtp03.taipei.via.com.tw>
References: <1177850259.17715.12.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiKlO-0007p5-4D for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 18:33:14 -0700
Received: from exchtp08.via.com.tw ([61.66.243.7])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiKlM-0001zx-N8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 18:33:14 -0700
Content-class: urn:content-classes:message
In-Reply-To: <1177850259.17715.12.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

Dear All,

I made the issue of size limitation.
I will resend the codes with 7 parts.

Best Regards,
Eddy Fu

-----Original Message-----
From: Antonino A. Daplas [mailto:adaplas@gmail.com] 
Sent: Sunday, April 29, 2007 8:38 PM
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eddy Fu
Subject: Re: [Linux-fbdev-devel] [PATCH 2/5] viafb: Framebuffer driver
for VIA UniChrome/Chrome9 HC

On Sat, 2007-04-28 at 10:42 +0800, EddyFu@via.com.tw wrote:

We did not receive patch 1 and patch 5. Most probably, they exceeded the
size of attachment limit.


> diff -Nur linux-2.6.21-rc7/drivers/video/via/hwcfig.h
> linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h
> --- linux-2.6.21-rc7/drivers/video/via/hwcfig.h 1969-12-31
> 19:00:00.000000000 -0500
> +++ linux-2.6.21-rc7.viafb/drivers/video/via/hwcfig.h 2007-04-26
> 19:52:32.000000000 -0400
> @@ -0,0 +1,399 @@
> + /*
> + * Copyright 1998-2007 VIA Technologies, Inc. All Rights Reserved.
> + * Copyright 2001-2007 S3 Graphics, Inc. All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person
> obtaining a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sub
> license,
> + * and/or sell copies of the Software, and to permit persons to whom
> the
> + * Software is furnished to do so, subject to the following
> conditions:
> + *
> + * The above copyright notice and this permission notice (including
> the
> + * next paragraph) shall be included in all copies or substantial
> portions
> + * of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT
> SHALL
> + * THE AUTHOR(S) OR COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> OR OTHER
> + * DEALINGS IN THE SOFTWARE.
> + */

Athough the text looks like X-MIT, and is therefore GPL compatible, I
(and Linus) would prefer an explicit note stating GPL compatibility. And
a Signed-off-by: (especially since the copyright owner is VIA and S3).

Until we receive the entire patch series, I will refrain from commenting
on this.

Tony

> 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
