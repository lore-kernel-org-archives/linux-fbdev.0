From: Manish RATHI <manish.rathi@st.com>
Subject: doubts
Date: Wed, 26 May 2004 17:10:37 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <000001c44316$487bf040$7c04b40a@dlh.st.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BSwmI-000808-Q4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 May 2004 04:40:58 -0700
Received: from beta.dmz-eu.st.com ([164.129.1.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BSwmI-0003yk-Dw
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 May 2004 04:40:58 -0700
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1CA79DA80
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 May 2004 11:40:50 +0000 (GMT)
Received: from mail2.dlh.st.com (localhost [127.0.0.1])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6183F12311
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 May 2004 11:40:48 +0000 (GMT)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1254"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Rohit JAIN <rohit.jain@st.com>

Hi,
In franebuffer  fb_info structure, there are 4 functions to be used by =
fbcon.c=20
these are:

(*updatevar)();
(*changevar)();
(*blank)();

Could anybody tell me the logic of above functions. Although they are =
mentioned in pl110.c and vfb.c but only function header is given.


Regards
Manish




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
