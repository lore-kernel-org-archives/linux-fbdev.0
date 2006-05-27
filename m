From: "Dave Airlie" <airlied@gmail.com>
Subject: intelfb updates
Date: Sat, 27 May 2006 18:58:47 +1000
Message-ID: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjudJ-00078W-DK
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 01:58:53 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjudJ-00031z-F3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 01:58:53 -0700
Received: from wr-out-0506.google.com ([64.233.184.227])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FjudF-0002B8-8Q
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 May 2006 01:58:53 -0700
Received: by wr-out-0506.google.com with SMTP id i20so257399wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 May 2006 01:58:47 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>, Dennis Munsie <dmunsie@cecropia.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I've just pushed my latest intelfb-2.6 tree to kernel.org, it contains
the patches from Dennis, and a sync of my X.org code.

Dennis I'd appreciate you testing this on your i945 system to see if
the PLL register problem is fixed, I'm a bit snowed under and my 945
isn't connected to anything at the moment.

I'd like to push this tree to Linus for 2.6.18, I'll go back and test
it on my i865, i915 and i945 at some point soon.

Dave.


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
