From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 08 May 2018 16:13:42 +0000
Subject: Re: [PATCH 00/18] Fix some build warnings/errors with Sphinx
Message-Id: <20180508101342.2bde20ea@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-can@vger.kernel.org

On Mon,  7 May 2018 06:35:36 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> I decided to give a try with Sphinx last stable version
> (1.17.4), and noticed several issues. The worse one was
> with the networking book: a non-standard footnote there
> with [*] instead of a number causes it to break PDF building.
> 
> So, I took some spare time to address some warnings all over
> the tree, and moved a few text documents to a book. 

OK, I've applied the ones that seem to make sense for me to take now.
There's comments on the firmware one, and I'd rather have Tejun's OK for
the cgroup one.  The code-comment changes should probably go via the
usual maintainers.

> I with
> I had more time to move the other ones and to solve other
> warnings.

You and me both - but each step helps!

Thanks,

jon
