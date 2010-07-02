From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH 0/3] ARM: S5PV210: Add MIPI-DSI support.
Date: Fri, 02 Jul 2010 14:34:27 +0100
Message-ID: <4C2DEAE3.9030903@simtec.co.uk>
References: <4C29AF72.6090200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C29AF72.6090200@samsung.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: InKi Dae <inki.dae@samsung.com>
Cc: kmpark@infradead.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org

On 29/06/10 09:31, InKi Dae wrote:
> Hello all,
> 
> This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).
> 
> LCD Panel can use following interfaces,
> - RGB or CPU Interface.
> - RGB or CPU Interface based on MIPI-DSI.
> 
> In case of small size lcd panel, it was ok only rgb or cpu interface not
> using mipi controller.
> But big size panel(more then 480x800) needs MIPI-DSI Interface or other
> hardwares like LVDS

Hmm, I must have imagined connecting up an 1024x768 panel to an RGB
interface then.
