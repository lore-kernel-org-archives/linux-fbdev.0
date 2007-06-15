From: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: Fix wrong line_length
	calculation
Date: Fri, 15 Jun 2007 10:49:11 +0200
Message-ID: <46725287.7020702@rfo.atmel.com>
References: <1179511541.3811.16.camel@bender>
	<1181647677482-git-send-email-hskinnemoen@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hz7Vz-0004cI-No for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 01:50:43 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hz7Vy-0003eL-0G
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 Jun 2007 01:50:43 -0700
In-Reply-To: <1181647677482-git-send-email-hskinnemoen@atmel.com>
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
To: Haavard Skinnemoen <hskinnemoen@atmel.com>, "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Patrice Vilchez <patrice.vilchez@rfo.atmel.com>, Andrew Victor <andrew@sanpeople.com>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>

Haavard Skinnemoen :
> As Jan Altenberg pointed out, line_length will always be 0 if
> bits_per_pixel < 8. Fix this and also make sure that we round up to
> the nearest byte.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---
> I haven't tested this with any real program that uses the frame buffer,
> but fbset seems to report sane values for line_length:

Thank you Haavard.

I have a bigger patch for all the support for STN display (tested with
mono STN display). It is based on the work from Jan Altenberg.

This bigger patch includes your modifications.

I send it right now. As a separate message.

Haavard, can you check if the compute_hozval()
function is ok on avr32 (I have reviewed with the at32ap7000 and hope 
that it is ok) ?


Regards,
-- 
Nicolas Ferre



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
