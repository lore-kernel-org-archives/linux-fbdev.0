From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] matroxfb update to new API
Date: Tue, 27 May 2003 21:54:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030527195446.GA10376@iliana>
References: <2BAC427619B@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp3.wanadoo.fr ([193.252.22.25] helo=mwinf0602.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19KkX9-0000tu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 May 2003 12:54:55 -0700
Content-Disposition: inline
In-Reply-To: <2BAC427619B@vcnet.vc.cvut.cz>
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
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Nicolas Souchu <nsouch@free.fr>, linux-fbdev-devel@lists.sourceforge.net

On Tue, May 27, 2003 at 09:46:45PM +0200, Petr Vandrovec wrote:
> On 27 May 03 at 21:44, Nicolas Souchu wrote:
> > On Tue, May 27, 2003 at 07:50:21PM +0200, Petr Vandrovec wrote:
> > > Hi,
> > >   I just created stripped down version of matroxfb - it is available
> > > as diff for 2.5.70 at 
> > > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz.
> > > 
> > >   I'll still update my own version of fbdev layer and matroxfb, as
> > > this stripped down driver is quite unusable for me.
> > >                       Petr Vandrovec
> > 
> > What do you mean exactly?
> 
> What I say... matroxfb driver & fbcon layer which supports fbset, updates
> all visible screens, supports text mode, implements clear_margins
> as black color and not current background color.
> 
> You can download that patch for several months from
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest - current latest is
> mga-2.5.69-c1155.gz, it applies to 2.5.70 with one offset. If you
> do not have Matrox graphics card in your device, then this patch is
> of no use for you.

If i have a matrox card and another supported by the new API, will both
work with this latest patch ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
