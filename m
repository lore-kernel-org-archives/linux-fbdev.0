From: Brad Douglas <brad@neruo.com>
Subject: Re: [Linux-fbdev-users] framebufer and radeonfb
Date: 26 Feb 2003 23:46:19 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046331979.4818.35.camel@12-235-123-161.client.attbi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from 12-235-107-98.client.attbi.com ([12.235.107.98] helo=12-235-123-161.client.attbi.com)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oIki-0005At-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Feb 2003 23:46:48 -0800
Received: from localhost (betamax [127.0.0.1])
	by 12-235-123-161.client.attbi.com (8.12.7/8.12.7) with ESMTP id h1R7kJTh006302
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Feb 2003 23:46:20 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net


On Wed, 2003-02-26 at 11:30, James Simmons wrote:
> > On Mon, 2003-02-24 at 06:49, leif gensert wrote:
> > > it still does not work :(
> > > 
> > My mistake.  The radeonfb needs "video=radeon:", ie without the 'fb'.
> > 
> > "video=radeon:1024x768"
> 
> Perhaps we should convert them all to end with fb?

I agree.  I believe this was discussed a few years ago and we
standardized on [driver]fb.  If we are all in agreement, I will go ahead
and make the changes.

-- 

Brad Douglas
brad@neruo.com

 37.493353 N
121.928953 W



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
