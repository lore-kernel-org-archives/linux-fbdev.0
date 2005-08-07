From: Nishant Kamat <nishantkamat@gmail.com>
Subject: Opinions about YUV framebuffers
Date: Sun, 7 Aug 2005 02:01:57 -0500
Message-ID: <ba2a6a4405080700015bfebaed@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1fAg-0003oS-H1
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 00:02:10 -0700
Received: from wproxy.gmail.com ([64.233.184.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1fAe-0004s0-Bc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 00:02:10 -0700
Received: by wproxy.gmail.com with SMTP id i21so580064wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 00:01:57 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi experts,

I'd like to solicit some opinions about using the fbdev API for a
display controller that accepts data in YUV format. fbcon seems to be
written to work only for RGB framebuffers. Is that correct? Would it
require lot of change to make it work with YUV data? Can X be run on
YUV framebuffers?

Any comments would help!

Thanks,
Nishant


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
