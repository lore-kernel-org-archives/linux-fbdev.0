From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Wed, 05 Mar 2003 23:13:05 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E667671.9040805@winischhofer.net>
References: <Pine.LNX.4.44.0303051932120.27760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qh7p-0006tX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 14:12:33 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



James Simmons wrote:
>>>We should split the monitor programing stuff out from stuff like bpp etc.
>>>Now if you think about it we can do things like change the bpp without 
>>>having to redo the monitor programming. This is the flaw with the old and 
>>>even the new api. 
>>
>>You could have done that from the beginning. Just look at which fields have
>>changed and which haven't.
> 
> 
> I should of but didn't because I knew driver would take teh path of lest 
> resistance to port there drivers. TO much change would have made the 
> current situtation much much worst. 

One could argue that changing stuff more or less constantly does not 
make it any easier to keep up with a working driver.... :)

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
