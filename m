From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: fbcon rotation or cyblafb bugs?
Date: Mon, 26 Dec 2005 11:21:42 +0100
Message-ID: <43AFC436.9090002@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EqpSh-0004DE-KO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Dec 2005 02:20:15 -0800
Received: from mailout10.sul.t-online.com ([194.25.134.21])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EqpSh-0005Un-8p
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 26 Dec 2005 02:20:15 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Can anybody confirm that clockwise / counterclockwise console rotation 
is working
or not working for arbitrary virtual x resolutions? Using cyblafb I get 
solid lockups
for certain combinations of font height and vxres. It does work 
perfectly reliable for
other combinations. It would be really nice if someone could run a test 
like e.g.

%!/bin/bash
setfont ...
echo -e "3" > /sys/class/graphics/fb1/con_rotate 
COUNTER=1280
while [ $COUNTER -lt 4080 ]; do
	fbset -s -fb /dev/fb1 -vxres $COUNTER -vyres ...
	cat testfile
	let COUNTER=COUNTER+8
done
echo -e "1" > /sys/class/graphics/fb1/con_rotate
COUNTER=1280
while [ $COUNTER -lt 4080 ]; do
	fbset -s -fb /dev/fb1 -vxres $COUNTER -vyres ...
	cat testfile
	let COUNTER=COUNTER+8
done

with some fonts of different dimensions using some other driver that 
supports
x-panning.

cu,
 knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
