From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Some questions
Date: 06 Mar 2003 21:25:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046957089.1197.2.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org>
	<1046913411.1206.185.camel@localhost.localdomain>
	<3E670B82.30900@winischhofer.net>
	<1046942633.1330.54.camel@localhost.localdomain>
	<3E671848.5020506@winischhofer.net>
	<1046945135.1209.76.camel@localhost.localdomain>
	<20030306103156.GA864@iliana>
	<1046947667.1330.87.camel@localhost.localdomain>
	<1046947834.1209.89.camel@localhost.localdomain> 
	<20030306114009.GA1770@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qvLw-00032T-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 05:24:05 -0800
In-Reply-To: <20030306114009.GA1770@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-06 at 19:40, Sven Luther wrote:
> > > 
> > > There's an EDID parser in fbmon.c.  I think it will work only for the
> > > PPC. This is currently used by rivafb and radeonfb. For the rest, either
> 
> Mmm, is it because the EDID parser uses the EDID information pased by
> the OF ?
> 

Yes.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
