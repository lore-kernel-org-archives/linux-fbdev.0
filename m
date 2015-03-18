From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 18 Mar 2015 10:52:56 +0000
Subject: Re: [PATCH RESEND 1/5] staging: sm750fb: Use memset_io instead of memset
Message-Id: <20150318105256.GR16501@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
 <20150318101717.GN10964@mwanda>
 <20150318101857.GO10964@mwanda>
 <CAA5enKZqRPx8a9Kk7cX1GJih9=N+Wj_zPbhg+hbLDJoKNEau-Q@mail.gmail.com>
In-Reply-To: <CAA5enKZqRPx8a9Kk7cX1GJih9=N+Wj_zPbhg+hbLDJoKNEau-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

On Wed, Mar 18, 2015 at 10:44:53AM +0000, Lorenzo Stoakes wrote:
> On 18 March 2015 at 10:18, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >>
> >> This changelog still sucks.  It doesn't describe the effect of this
> >> behavior change for the user.  It doesn't even make it clear that you
> >> are aware that this is a behavior change.
> >
> > It doesn't say to me that you have asked yourself if the sparse
> > annotations are correct.  Many times they are wrong.
> 
> My understanding, which as a new contributor is of course limited and
> likely simply wrong in many aspects, is - these memset's are referring
> to I/O mapped memory, which as far as I can tell is actually the case
> here, so in order to make it explicit that this is the case and we
> know it is, we use memset_io. As far as I understand the pointers
> simply have a modifier applied which marks them as I/O mapped memory
> for the purposes of sparse checking whether they are used consistently
> as such and are not treated like they are a normal kernel pointer.
> 
> In this case the cursor->vstart and crtc->vScreen pointers, looking
> through the source, explicitly refer to memory which is I/O mapped,
> and is annotated as __iomem accordingly throughout.
> 
> I will update the message accordingly, obviously if I'm
> misunderstanding something let me know.

This is all fine.

> 
> > We have had this discussion before but you still sent the same exact
> > bad changelog.
> 
> Actually you said:-
> 
> > When I see a patch like this, then I worry, "What if the Sparse
> > annotations are wrong?  The patch description doesn't say anything about
> > that."  After review then I think the annotations are correct so that's
> > fine.
> 
> And:-

The patch is fine.  The changelog is not.

> 
> > Yes.  The patch is correct.  I wasn't asking you to redo it.  From later
> > patches it's actually clear that you know that this change is a bugfix
> > and a behavior change.  But we get a lot of patches where people just
> > randomly change things to please Sparse and it maybe silences a warning
> > but it's not correct.  I can think of a few recentish examples where
> > people used standard struct types which hold __iomem or __user pointers
> > but they used them in non-standard ways so the pointers were actually
> > normal kernel pointers.
> 
> So it wasn't clear *to me* you wanted me to change that, given you
> asked me *not* to redo it explicitly (which I assumed applied to the
> message too) - apologies if I misinterpreted this!

I often say "don't resend" because something is minor and I don't want
to slow you down but since you were resending it anyway then please fix
it.  Also changelogs are really easy to fix.  In mutt, you can do it
without leaving your email client.  So I have revised my earlier
statement, please fix it.  :)

regards,
dan carpenter

