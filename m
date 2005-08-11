From: Jon Smirl <jonsmirl@gmail.com>
Subject: mono, gray and index configs
Date: Wed, 10 Aug 2005 23:21:01 -0400
Message-ID: <9e47339105081020216574ac7e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E33d0-0003Ah-5y
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 20:21:10 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E33cy-0006QA-Tu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 20:21:10 -0700
Received: by wproxy.gmail.com with SMTP id i3so270651wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 20:21:01 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

When filling in a fb_var_screeninfo how do I ask for mono, gray and
index configs? Is is always request length red and green/blue length =3D
zero to indicate a mono, gray or index config? Then grayscale is used
to differentiate gray/mono from indexed?

Are there any more tricks to asking for a config? One trick I see is
if bpp is set to a value where the hardware only supports one format
at that bpp, ignore rbgt and set the config.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
