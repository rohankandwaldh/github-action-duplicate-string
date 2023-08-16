package com.example.github_action_duplicate_strings

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.ViewHolder

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)

        val rvStuff = findViewById<RecyclerView>(R.id.rvStuff)
        val items = mutableListOf<Pair<String, String>>()
        items.add(Pair("A", "1"))
        items.add(Pair("A", "2"))
        items.add(Pair("A", "3"))
        items.add(Pair("A", "4"))
        items.add(Pair("A", "5"))
        items.add(Pair("A", "6"))
        items.add(Pair("A", "7"))
        items.add(Pair("A", "8"))
        items.add(Pair("A", "9"))
        items.add(Pair("A", "10"))
        items.add(Pair("A", "11"))
        items.add(Pair("A", "12"))
        items.add(Pair("A", "13"))
        items.add(Pair("A", "14"))
        items.add(Pair("A", "15"))
        items.add(Pair("A", "16"))
        items.add(Pair("A", "17"))
        items.add(Pair("A", "18"))
        items.add(Pair("A", "19"))
        rvStuff.adapter = RVStuffAdapter(items)
    }
}

class RVStuffAdapter(private val items: List<Pair<String, String>>): RecyclerView.Adapter<RVStuffViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RVStuffViewHolder {
        return RVStuffViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.child_adapter, parent, false))
    }

    override fun getItemCount(): Int {
        return items.size
    }

    override fun onBindViewHolder(holder: RVStuffViewHolder, position: Int) {
        holder.tvName.text = items[position].second
        holder.tvPrice.text = items[position].second

        holder.tvPrice.post {
            holder.tvPrice.text = items[position].second
//            Thread.sleep(500)
        }
    }
}



class RVStuffViewHolder(itemView: View) : ViewHolder(itemView) {
    val tvName = itemView.findViewById<TextView>(R.id.tvName)
    val tvPrice = itemView.findViewById<TextView>(R.id.tvPrice)
}
