From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2/5] viafb: Framebuffer driver
	for	VIA UniChrome/Chrome9 HC
Date: Sun, 29 Apr 2007 20:37:39 +0800
Message-ID: <1177850259.17715.12.camel@daplas>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB887D2E8@exchtp03.taipei.via.com.tw>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi8fN-0003Hy-Ey for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 05:38:13 -0700
Received: from wx-out-0506.google.com ([66.249.82.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi8fM-00018Y-K6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 05:38:13 -0700
Received: by wx-out-0506.google.com with SMTP id i30so2227810wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 29 Apr 2007 05:38:11 -0700 (PDT)
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB887D2E8@exchtp03.taipei.via.com.tw>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: EddyFu@via.com.tw

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
