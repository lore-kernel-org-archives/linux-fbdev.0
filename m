From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 17:17:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E662336.9030203@winischhofer.net>
References: <3E65EAFB.7020208@winischhofer.net>	<1046870342.1291.86.camel@localhost.loca	 ldomain> 	<3E66044D.5030007@winischhofer.net>	<1046877920.1228.190.camel@localhost.localdomain> 	<3E6619A5.7020502@winischhofer.net> <1046880323.1289.209.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qbdR-0004bB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 08:20:50 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
>> > Strange.  If you boot at 800x600, the console will compute that as
>> > 100x37.  On fbcon_resize, it will request 800x592 but because the
>> > difference is only 8, fb_set_var should be skipped, so no mode change
>> > should happen throughout.
>>
>>But it definitely does. I can see this on my LCD (which goes dark during 
>>mode changes) and, of course, the log.

Just check this with the newest versions from fbdev at bk. In my code 
(which is, as I said in the beginning, the stock 2.5.63 kernel), 
fbcon_resize does NO check whatsoever. It stupidly calls set_var().

I think that might be one reason for what I see :)

Now for a plain dumb question: Is there a patch available to update my 
kernel tree to the latest fbdev stuff? (I don't intend to spend much 
time with bk)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
