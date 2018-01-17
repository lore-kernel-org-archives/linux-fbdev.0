From: Max Staudt <mstaudt@suse.de>
Date: Wed, 17 Jan 2018 20:54:22 +0000
Subject: [RFC PATCH v3 00/13] Kernel based bootsplash
Message-Id: <20180117205435.2860-1-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, philm@manjaro.org, bernhard.rosenkranzer@linaro.org, kernel.max@enpas.org

Dear fbdev/fbcon/dri developers,

Thanks for all the valuable feedback.

I've looked into the suggestions you made, and found that it doesn't
currently make sense to continue working on the splash code, given the
low practical interest I've received on LKML. The code is, and always
has been, intended primarily as a study of what can be done, and at
this point it has fulfilled this requirement.

Please find attached my latest version of the patchset in which I've
clarified the documentation a bit, as well as added a FAQ and To-Do
section for anyone wishing to pick up the code.

The code is still based on v4.14-rc5, sorry about that.

In particular, I hope to have clarified in the FAQ why I'm building on
top of fbdev and fbcon, as I think I haven't made myself clear enough
in the previous discussion. If you still think that my reasoning is
wrong, I'd be thankful for pointers towards a better solution.


I'll be happy to rebase it and continue to work on it if interest
arises.


This project has been a valuable experience - so huge thanks to everyone
involved in any way, from user feedback over code reviews and all the way
to architectural discussion.


Max


