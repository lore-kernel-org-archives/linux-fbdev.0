From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Date: Tue, 20 May 2003 20:05:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2110DE22C31@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19IBUR-00052T-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 May 2003 11:05:32 -0700
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
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Brett <generica@email.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

On 20 May 03 at 18:18, Dave Jones wrote:
> On Tue, May 20, 2003 at 05:55:41PM +0100, James Simmons wrote:
> 
>  > > Wasn't the EDID stuff getting backed out anyways ?
>  > Only in the VESA driver. Some people did have luck with the BIOS EDID info 
>  > so I like to keep the BIOS call in there. 
> 
> That code runs way earlier than before we get to do any PCI quirks,
> so fixing that one up could be interesting.

On my system (G450 + Compaq MV600 + TV) this EDID call takes about 
5 seconds (fortunately it does not die), so I'll be happy if I can config
this out - especially as matroxfb gives you DDC access from inside Linux.
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
