From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: intelfb updates
Date: Tue, 30 May 2006 15:58:02 -0400
Message-ID: <2E36B04D-0D7E-4D25-B2C7-D3EF201FFB1E@cecropia.com>
References: <21d7e9970605270158l1ee8551cw7cc8910378cc43de@mail.gmail.com> <509BC7A5-C965-47C5-BB5F-416EC23D508A@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlAL3-0002ME-Ul
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 12:57:13 -0700
Received: from mail1.sea5.speakeasy.net ([69.17.117.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FlAL3-0003QR-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 12:57:14 -0700
In-Reply-To: <509BC7A5-C965-47C5-BB5F-416EC23D508A@cecropia.com>
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
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@gmail.com>, Eric Hustvedt <ehustvedt@cecropia.com>

another update --

I broke apart the commit that Dave titled "align with changes from my  
X driver" into 4 patches -- one for each routine modified.  If I  
apply all of them except the calc_vclock() patch and also all of the  
other patches that Dave has in git, everything works.  No black display.

So, whatever the new calc_vclock() is doing is causing problems, and  
doesn't seem to be contributing much :)

As soon as that is fixed, I would say that 945 support is working  
well (at least better than it had been).

dennis

On May 30, 2006, at 2:05 PM, Dennis Munsie wrote:

> I pulled down the changes in your git tree, and when I apply them,  
> I get a kernel panic:


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
