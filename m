From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ATI X600 on 2.6.15
Date: Fri, 06 Jan 2006 09:27:46 +1100
Message-ID: <1136500066.4840.98.camel@localhost.localdomain>
References: <20060105014229.GB10726@localhost>
	 <1136455013.4840.73.camel@localhost.localdomain>
	 <20060105113148.GA21807@localhost>
	 <a5d587fb0601051230y1c8c0dddo46f08ad678524067@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EudZQ-0007rv-0x
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 14:26:56 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EudZO-0000HD-FQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Jan 2006 14:26:56 -0800
In-Reply-To: <a5d587fb0601051230y1c8c0dddo46f08ad678524067@mail.gmail.com>
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
To: Michal Suchanek <hramrach@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, bob.picco@hp.com

On Thu, 2006-01-05 at 21:30 +0100, Michal Suchanek wrote:
> On 1/5/06, Bob Picco <bob.picco@hp.com> wrote:> From xorg.conf:> # This loads the DRI module> #    Load     
>   "dri">> So DRI is disabled.>Not neccessrily. IIRC I disabled explicit loading of dri because itloaded automagically.

Best is to move the kernel module out of the way

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
