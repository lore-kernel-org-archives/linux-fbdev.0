From: Jiang Liu <liuj97@gmail.com>
Date: Fri, 31 May 2013 04:31:15 +0000
Subject: Re: [PATCH v8, part3 06/14] mm, acornfb: use free_reserved_area() to simplify code
Message-Id: <51A82793.4080204@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com> <1369575522-26405-7-git-send-email-jiang.liu@huawei.com> <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
In-Reply-To: <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <james.bottomley@hansenpartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <florianschandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Fri 31 May 2013 05:58:44 AM CST, Andrew Morton wrote:
> On Sun, 26 May 2013 21:38:34 +0800 Jiang Liu <liuj97@gmail.com> wrote:
>
>> Use common help function free_reserved_area() to simplify code.
>
> http://ozlabs.org/~akpm/mmots/broken-out/drivers-video-acornfbc-remove-dead-code.patch
> removes all the code which your patch alters.
Thanks Andrew, please just drop that patch.

