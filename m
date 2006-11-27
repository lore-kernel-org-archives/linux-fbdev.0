From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
 seconds to initialize
Date: Mon, 27 Nov 2006 11:36:57 -0700
Message-ID: <20061127183657.GE588@cosmic.amd.com>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
	<808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
	<20061121003447.GD5160@cosmic.amd.com>
	<808c8e9d0611210618n2d54aaft1e2afb1c73dcf74a@mail.gmail.com>
	<808c8e9d0611270828m4ff91349mdc7bf03fd6875e91@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GolGD-0003lb-NH for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 10:31:21 -0800
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]
	helo=outbound2-cpk-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GolGA-0007Sg-As
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 10:31:21 -0800
In-Reply-To: <808c8e9d0611270828m4ff91349mdc7bf03fd6875e91@mail.gmail.com>
Content-Disposition: inline
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
Cc: James Simmons <jsimmons@infradead.org>

On 27/11/06 10:28 -0600, Ben Gardner wrote:
> Out of curiosity, where are the magic registers (0xAC1C, 0xAC1E) documented?
> I searched "AMD Geode GX Processors Data Book", but had no luck...

Those are virtual magic registers courtesy of our VSA.  The document is
on the Developers website, though its probably time that I go down and throw
things until the technical marketing department agrees to put that document
on the public site as well.

> Also, I notice that the pci_resource_len() shows 16 MB, even though
> the resource should only cover 4 MB.  I assume this is a BIOS bug...
> =)

You say bug, I say limitation... :)  IIRC, PCI resource sizes can only
be powers of two, but the video memory doesn't nessesarly need to be a power
of two.    So the VSA just sets the PCI resource to 16MB and expects the
code to access the virtual register, as you have experienced.

> Is there anything I can do to help get this pushed into the 2.6.19 kernel?

Ask folks more important then me... :)  I don't know if this really
qualifies for a -rc release.  There should be nothing standing in our way
for 2.6.20, though (I hope).

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
