From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Sat, 08 Mar 2003 15:11:35 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E69FA17.7060705@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.80	 80506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain>	<3E68B895.2080500@winischhofer.net>	<1047067923.1226.26.camel@localhost.localdomain> 	<3E69065D.3090706@winischhofer.net> 	<1047084988.2388.4.camel@localhost.localdomain> <1047101983.1231.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from static213-229-38-018.adsl.inode.at ([213.229.38.18] helo=home.winischhofer.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rf3A-0006US-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 08 Mar 2003 06:11:44 -0800
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
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Antonino Daplas wrote:
>> 	p->vrows = info->var.yres_virtual / vc->vc_font.height;
>>+	p->vrows -= info->var.yres/h - vc->vc_rows;
> 
>                     ^^^^^^^^^^^^^^^^
> 
> I also meant info->var.yres/vc->vc_font.height :-)

Tony,

Both ways it works, granted. But I still don't see the advantage of your 
solution over mine. Your's wastes an area of the size of a whole screen.

Certainly no offence, but can you explain why you think this is better?

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
