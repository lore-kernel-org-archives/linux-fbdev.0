From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Re: [PATCH 9/10] i810fb: Add i2c/DDC support
Date: Sun, 04 Sep 2005 15:51:31 +0200
Message-ID: <1125841891.7590.52.camel@tom>
References: <43177635.8020005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBuuN-0000zt-9q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 06:51:43 -0700
Received: from 26.mail-out.ovh.net ([213.186.42.179])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EBuuK-0006bk-Tp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 06:51:43 -0700
In-Reply-To: <43177635.8020005@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello Antonino,

I have an information that may interest you: On i865G, you can connect
an AGP daughter card to add a DVI connector. The I2C bus of this
connector is accessed using the register that I called GPIO"C", and its
offset is 0x0501C (it is not documented in Intel datasheets). It works
exactly like the busses on GPIOA (0x05010) and GPIOB (0x05014), i.e. you
can reuse the same functions.

BTW, you could merge i810i2c_* and i810ddc_* functions, as they are the
same excepting the register address (you did this in rivafb).

Also note that your code to read/write to the I2C busses has been
reported to work on i915G (I don't know about the real framebuffer
support).

Best regards,

Nicolas

On Fri, 2005-09-02 at 05:44 +0800, Antonino A. Daplas wrote:
>     Add ddc/i2c support for i810fb.  This will allow the driver to
>     get display information, especially for monitors with fickle timings.
>     The i2c support depends on CONFIG_FB_I810_GTF.
>     
>     Changed __init* to __devinit*
>     
>     Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
[snip]




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
