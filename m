From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 30 May 2013 21:58:44 +0000
Subject: Re: [PATCH v8, part3 06/14] mm, acornfb: use free_reserved_area() to simplify code
Message-Id: <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com>
	<1369575522-26405-7-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369575522-26405-7-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiang Liu <liuj97@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Sun, 26 May 2013 21:38:34 +0800 Jiang Liu <liuj97@gmail.com> wrote:

> Use common help function free_reserved_area() to simplify code.

http://ozlabs.org/~akpm/mmots/broken-out/drivers-video-acornfbc-remove-dead-code.patch
removes all the code which your patch alters.
