From: Markus Schorer <ms@plain.de>
Subject: Re: Driver for Sharp LH155BA
Date: Tue, 01 Aug 2006 08:58:20 +0200
Message-ID: <44CEFB8C.70009@plain.de>
References: <170385E48B041543AC99CCD09E325AD1952BB9@mail.rogermanagement.com.au>
	<44CEABDB.3040702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G7o9f-0004Ri-BJ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 23:55:03 -0700
Received: from black.plain.de ([212.18.1.2])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G7o9c-0003xM-RF
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 31 Jul 2006 23:55:03 -0700
Received: from [192.168.1.10] (p3E9E2BE3.dip0.t-ipconnect.de [62.158.43.227])
	by black.plain.de (Postfix) with ESMTP id 42A0E5C131F8
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue,  1 Aug 2006 10:26:12 +0200 (CEST)
In-Reply-To: <44CEABDB.3040702@gmail.com>
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

Antonino A. Daplas wrote:
> Richard Wolf wrote:
>> Presumably if I take the shadow buffer route then I could maintain _two_
>> shadow buffers.  This would allow me to detect whether the user accessib=
le
>> buffer had been changed and update the display only when necessary.  =

> =

> Yes, that will work too.
> =


check for the epson SED15xx (not sure) driver. sounds like similar =

hardware, same approach.

markus
-- =

_______________________________________________________________________
plain GmbH        | daiserstrasse 15      | 81371 m=FCnchen
fon 089.540.149.0 | fax 089.540.149.44    | http://www.plain.de

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
