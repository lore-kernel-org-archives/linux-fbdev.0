From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Wed, 16 Sep 2020 07:42:14 +0000
Subject: Re: [PATCH] docs: fb: Remove framebuffer scrollback option for boot
Message-Id: <20200916073014.GA21744@Gentoo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915222511.17140-1-unixbhaskar@gmail.com>
 <20200916022552.GB13409@1wt.eu>
 <20200916030416.GA20404@Gentoo>
 <20200916044438.GA13670@1wt.eu>
In-Reply-To: <20200916044438.GA13670@1wt.eu>
To: Willy Tarreau <w@1wt.eu>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06:44 Wed 16 Sep 2020, Willy Tarreau wrote:
>On Wed, Sep 16, 2020 at 08:34:16AM +0530, Bhaskar Chowdhury wrote:
>> > In addition below:
>> >=20
>> > On Wed, Sep 16, 2020 at 03:55:11AM +0530, Bhaskar Chowdhury wrote:
>> > > This patch remove the scrollback option under boot options.
>> > > Plus readjust the numbers for the options in that section.
>> > >=20
>> > > Commit 973c096f6a85(vgacon: remove software scrollback support)
>> > > Commit 50145474f6ef(fbcon: remove soft scrollback code)
>> >=20
>> > This is still not clear. The message should indicate the "why" more
>> > than the "what" which can be figured from the patch. In addition,
>> > only the fbcon commit is a cause for these changes. Last, Greg
>> > mentioned that the format is 'commit xxx ("subject")'.
>> >=20
>> > What about this:
>> >=20
>> >  The "scrollback" boot option was removed by commit 50145474f6ef
>> >  ("fbcon: remove soft scrollback code"), but the doc for fbcon was
>> >  not updated.  This patch updates the fbcon doc and renumbers the
>> >  sections.
>> >=20
>>=20
>> I lost it ...by head failed me ...do you want me copy more information t=
ext
>> from the actual commit??
>
>No, it's just that your commit messages are not clear at all. You
>mention that you remove something and point another commit without
>any explanation about the link between them. I'm just proposing an
>example of how to better explain the justification for your patch.
>
>As a rule of thumb, when you propose a patch for inclusion, always
>think that you're trying to sell it to someone else who will have
>to take care of its consequences forever. So you must put all the
>good arguments on it, just as if it was printed on the package of a
>product. Of course here it's just a tiny doc patch but the principle
>remains, the why and how still needs to be clear.
>
>> > If you merge all your patches together, you can have this:
>> >=20
>> >  The "scrollback" boot option was removed by commit 50145474f6ef
>> >  ("fbcon: remove soft scrollback code"), but the fb docs were not
>> >  updated.  This patch removes reference to this option in the fbcon,
>> >  matroxfb, sstfb and vesafb docs and renumbers the sections as needed.
>> >=20
>> > And please increase your version so that it's more obvious that this
>> > replaces previous series. Call it v3 or v4 or whatever higher than
>> > the highest you've ever sent so that it's easier for your readers to
>> > ignore the older ones. Ideally after your signed-off-by you should
>> > add a "---" line with a quick changelog indicating what changed from
>> > the previous ones (just for reviewers, this will not be merged), for
>> > example:
>> >=20
>> Okay, before sending this new set ...yesterday I wrote a mail to everyon=
e ,
>> that I wanted to get rid of this damn versioning thing and will sent pat=
ches
>> afresh. So, ask everyone involved please ignore what have sent previousl=
y and
>> that mail too. I am sure that missed your eyes ...and I understand why :)
>>=20
>> But I am still reluctant to bump up the version number and would like to=
 sent
>> all the 4 patches AFRESH(which has nothing to do with the previous patch=
tes I
>> have sent) .
>
>Who cares ? Is a version expensive in any way ? Is there any shame in
>sending multiple versions ? Put yourself in the place of your recipients.
>They receive 500-2000 emails a day, get yours possibly in a random order
>if their connection is a bit flaky, and are not always perfectly sure
>which ones are still relevant after some comments were emitted by others.
>The version is just a simple way to say "ignore everything I sent before
>this one". If you send a v3, it will be obvious that anything without any
>version or marked v2 can safely be ignored.
>
>In addition you say that you send a fresh series, but even that series was
>very confusing, with patches having almost the same names more or less one
>word ("stanza" vs "line") so it was not clear whether each patch was a new
>attempt at fixing a typo in the previous one or for something different. A
>version number clarifies that. And numbering the patches as well by the wa=
y.
>
>> Can I do that Willy???
>
>You can do whatever you want. We all find the rules annoying when we have
>to follow them but convenient from the recipient side. Thus it's just a
>matter of whether or not you want to increase the chances that your patches
>are caught by someone and merged. The more confusing they are, the less
>likely someone will be willing to spend valuable time on them, and once
>they're out of the visible window they're forgotten. I'd suggest that you
>usually go the easy way first and once you get some reviews you need to
>be careful to address them completely and accurately (or indicate your
>disapproval and why).
>
>> >   Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> >   ---
>> >   v3: clarify message description, update all fb drivers in the same p=
atch
>> >   v2: reword commit message
>> >=20
>> This chainlog of information in the patch getting spirial and not helpful
>> AFAIK. I mean, the version bumping and provide information appended to e=
very
>> other following mail. If that is significant then I understand ...but fo=
r this thing....I
>> hope you get me...
>
>I'd say that for that trivial a patch it's probably not very useful,
>just like it can be dropped in a fast round trip with a person on a
>short topic. But when you get some reviews, reviewers never know if
>you wrote the new series before, during or after their review, and not
>knowing if you took their comments into consideration either makes
>them hesitant to review again, or irritated seeing that they were not
>considered yet. Just for this it's a good practice to mention what
>comments were addressed here. It's just an Ack for the reviewers to
>say "I tried to follow your advice, if it's still wrong, let me know".
>For example Greg made some very precise comments about the format he
>expected for the commit IDs, that apparently you still got wrong several
>times. How can he know if you tried to address that and failed, or just
>read it after sending ?
>
>Willy


Hmmm ....okay...every words your wrote is absolutely right and that is how =
it
is been practicing here in this project.=20

I am not sure why the hell I deviated from that rule or practice.

My sincere apologies to everyone ,whoever getting my mail for this specific
patch series.

Look like we need someone good at sending patches proper way.=20

It seems, I am going to get into the "kill file" of lot of people ...meh ..=
heck

Keeping all the words in mind  Yours and Greg's(Please don't fret) ..well a=
nother
hoorah at the patch making and send of this series. And I sincerely don't k=
now
this time who bothers about my sending ....I do hope ..

 =20
~Bhaskar=20

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9hvwMACgkQsjqdtxFL
KRVqEgf/fWTEgQGppDuuFyPN6i3nPtBrwfPGIR+gtagT9GfPDpp8W668bi6X4h0O
iIdFiU950g1lZuBjOJCJQwlw/cQrIoZ2r4x2rQ3PcflMVVOaBgqgZvgPM7PoUWVA
5pc6heruah2bo5fXpmSWQd5D0Fnz68D04M1CvFq5jHcxflWeqz5vDNih4EoxcoE4
hv3v6uIHkXt9U1NcvtFVySN88YyZ6LiePltaLNlJDgE8KSJeezz155ouslACuxGU
b2FK8ZRHQk4S5FO5l1+2WrswnzgRfihR0UkfbXm8nAWn3Kw1FatmRz9RJ5ECY3kD
KT6osIDOm/70LydN0QoXAU/1rdKO3g==
=P3QL
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
