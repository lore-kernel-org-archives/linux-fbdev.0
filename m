From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] matroxfb update to new API
Date: Tue, 27 May 2003 22:05:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2BB137F3115@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Kkhd-0000Oi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 May 2003 13:05:45 -0700
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas Souchu <nsouch@free.fr>, linux-fbdev-devel@lists.sourceforge.net

On 27 May 03 at 21:54, Sven Luther wrote:
> On Tue, May 27, 2003 at 09:46:45PM +0200, Petr Vandrovec wrote:
> > On 27 May 03 at 21:44, Nicolas Souchu wrote:
> > > On Tue, May 27, 2003 at 07:50:21PM +0200, Petr Vandrovec wrote:
> > > > Hi,
> > > >   I just created stripped down version of matroxfb - it is available
> > > > as diff for 2.5.70 at 
> > > > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz.
> > > > 
> > > >   I'll still update my own version of fbdev layer and matroxfb, as
> > > > this stripped down driver is quite unusable for me.
> > > >                       Petr Vandrovec
> > > 
> > > What do you mean exactly?
> > 
> > What I say... matroxfb driver & fbcon layer which supports fbset, updates
> > all visible screens, supports text mode, implements clear_margins
> > as black color and not current background color.
> > 
> > You can download that patch for several months from
> > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest - current latest is
> > mga-2.5.69-c1155.gz, it applies to 2.5.70 with one offset. If you
> > do not have Matrox graphics card in your device, then this patch is
> > of no use for you.
> 
> If i have a matrox card and another supported by the new API, will both
> work with this latest patch ?

Unfortunately no. It should work if you'll add dummy 'con' argument
to the fb_ioctl, and dummy struct vc_data* to fb_check_var. Rest of
code should correctly branch according to the value of fbinfo's 
matroxfb_switch_con field, and fbops's fb_{get,set}_cmap, fb_putcs,
set_font and cursor fields (NULL => use cfb_imageblit for putc,
fb_cursor for cursor, and generic code for setfont and cmap).

I never tried to update new vesafb to this interface, as supporting
fbset on /dev/tty* was already vetoed long ago, and I have no problem
with maintaining it outside of tree.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
