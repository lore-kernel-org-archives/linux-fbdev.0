From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Sun, 06 Jun 2004 15:19:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40C319D6.5020805@winischhofer.net>
References: <20040603024412.GE20951@havoc.gtf.org> <40BEF4ED.7090909@winischhofer.net> <1086269209.40bf27191fe1c@mail.theboonies.us> <40BF5482.7080900@winischhofer.net> <1086282526.40bf5b1e52eca@mail.theboonies.us> <Pine.GSO.4.58.0406061315370.4558@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWxZU-00049v-H7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 06:20:20 -0700
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BWxZR-0003ei-1P
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 06:20:17 -0700
In-Reply-To: <Pine.GSO.4.58.0406061315370.4558@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Eger <eger-dated-1086887330.ffe1f7@theboonies.us>, David Eger <eger@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Thu, 3 Jun 2004, David Eger wrote:
> 
>>I guess I shouldn't mark it "stupid shit" until I actually have the replacement
>>code ready ;-)  You want me to revise the name of the #define?
> 
> 
> Yes, please do so. We need it for backwards compatibility.

ARGH.... well then, but please keep the #define STUPID... now that I 
committed an update of sisfb to Andrew.

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
