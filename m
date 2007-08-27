From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 16/20] cyber2000fb: code cleanup
Date: Mon, 27 Aug 2007 15:25:23 -0700
Message-ID: <20070827152523.c045ff2d.akpm@linux-foundation.org>
References: <46D1896F.9030306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPn1b-0005gr-9s for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 15:25:35 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IPn1Y-0002Ex-RS
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 15:25:35 -0700
In-Reply-To: <46D1896F.9030306@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 26 Aug 2007 22:08:47 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> This patch fixes errors and warnings pointed
> out by the checkpatch.pl script.
> 
> [adaplas: Replaced BIT with ENCODE_BIT)]

This patch collided with the bit-macro patches which I recently added to
-mm:

fs-select-remove-unused-macros.patch
cyber2000fb-rename-bit-macro.patch
i2c-pxa-rename-bit-macro-to-pxa_bit.patch
s2io-rename-bit-macro.patch
amba-pl011-rename-bit-macro.patch
define-first-set-of-bit-macros.patch
get-rid-of-input-bit-duplicate-defines.patch
define-global-bit-macro.patch
flashpoint-use-bit-instead-of-bitw.patch

Those patches are a sensible consolidation so methinks it'd be good to do
this cleanup on top of that work?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
